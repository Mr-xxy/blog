---
title: Composition API归纳
date: 2020-09-01 16:00:00
tags:
    -vue3
categories:
    - 技术分享
---

# 前言

## 动机与目的

#### 更好的逻辑复用与代码组织

 Vue 当前 API编程模型的限制：

1. 随着功能的增长，复杂组件的代码变得越来越难以阅读和理解。这种情况在开发人员阅读他人编写的代码时尤为常见。根本原因是 Vue 现有的 API 迫使我们通过选项组织代码，但是有的时候通过逻辑关系组织代码更有意义。
2. 目前缺少一种简洁且低成本的机制来提取和重用多个组件之间的逻辑。

#### 更好的类型推导

大型项目开发者的常见需求是更好的 TypeScript 支持
<!-- more -->
# API

## `setup`

**理解**

setup()函数是vue3中新增的方法，可以理解为Composition Api的入口.

**执行时机**

在beforeCreate之前执行.

**模板中使用**

如果 `setup` 返回一个对象，则对象的属性将会被合并到组件模板的渲染上下文：

```html
<template>
  <div>{{ count }} {{ object.foo }}</div>
</template>

<script>
  import { ref, reactive } from 'vue'

  export default {
    setup() {
      const count = ref(0)
      const object = reactive({ foo: 'bar' })
      // 暴露给模板
      return {
        count,
        object,
      }
    },
  }
</script>
```

**接收props数据**

然而**不要**解构 `props` 对象，那样会使其失去响应性：

```javascript
export default {
  props: {
    msg: {
      type: String,
      default: () => {}
    }
  },
  setup(props) {   // 不要写成setup({ msg })
    console.log(props.msg);
  }
}
```

## 响应式系统 API

### `reactive`

接收一个普通对象然后返回该普通对象的响应式代理。等同于 2.x 的 `Vue.observable()`

```js
const obj = reactive({ count: 0 })
```

### `ref`

接受一个参数值并返回一个响应式且可改变的 ref 对象。ref 对象拥有一个指向内部值的单一属性 `.value`。

```js
const count = ref(0)
console.log(count.value) // 0

count.value++
console.log(count.value) // 1
```

如果传入 ref 的是一个对象，将调用 `reactive` 方法进行深层响应转换。

**模板中访问**

当 ref 作为渲染上下文的属性返回（即在`setup()` 返回的对象中）并在模板中使用时，它会自动解套，无需在模板内额外书写 `.value`：

```html
<template>
  <div>{{ count }}</div>
</template>

<script>
  export default {
    setup() {
      return {
        count: ref(0),
      }
    },
  }
</script>
```

### `computed`

传入一个 getter 函数，返回一个默认不可手动修改的 ref 对象。

```js
const count = ref(1)
const plusOne = computed(() => count.value + 1)

console.log(plusOne.value) // 2

plusOne.value++ // 错误！
```

或者传入一个拥有 `get` 和 `set` 函数的对象，创建一个可手动修改的计算状态。

```js
const count = ref(1)
const plusOne = computed({
  get: () => count.value + 1,
  set: (val) => {
    count.value = val - 1
  },
})

plusOne.value = 1
console.log(count.value) // 0
```

### `watchEffect`

立即执行传入的一个函数，并响应式追踪其依赖，并在其依赖变更时重新运行该函数。

```js
const count = ref(0)

watchEffect(() => console.log(count.value))
// -> 打印出 0

setTimeout(() => {
  count.value++
  // -> 打印出 1
}, 100)
```

#### 停止侦听

当 `watchEffect` 在组件的 `setup()` 函数或生命周期钩子被调用时， 侦听器会被链接到该组件的生命周期，并在组件卸载时自动停止。

在一些情况下，也可以显式调用返回值以停止侦听：

```js
const stop = watchEffect(() => {
  /* ... */
})

// 之后
stop()
```

### `watch`

`watch` API 完全等效于 2.x `this.$watch` （以及 `watch` 中相应的选项）。`watch` 需要侦听特定的数据源，并在回调函数中执行副作用。默认情况是懒执行的，也就是说仅在侦听的源变更时才执行回调。

- 对比 `watchEffect`，`watch` 允许我们：
  - 懒执行副作用；
  - 更明确哪些状态的改变会触发侦听器重新运行副作用；
  - 访问侦听状态变化前后的值。

- **侦听单个数据源**

  侦听器的数据源可以是一个拥有返回值的 getter 函数，也可以是 ref：

  ```js
  // 侦听一个 getter
  const state = reactive({ count: 0 })
  watch(
    () => state.count,
    (count, prevCount) => {
      /* ... */
    }
  )
  
  // 直接侦听一个 ref
  const count = ref(0)
  watch(count, (count, prevCount) => {
    /* ... */
  })
  ```

- **侦听多个数据源**

  `watcher` 也可以使用数组来同时侦听多个源：

  ```js
  watch([fooRef, barRef], ([foo, bar], [prevFoo, prevBar]) => {
    /* ... */
  })
  ```

## 生命周期钩子函数

可以直接导入 `onXXX` 一族的函数来注册生命周期钩子：

```js
import { onMounted, onUpdated, onUnmounted } from 'vue'

const MyComponent = {
  setup() {
    onMounted(() => {
      console.log('mounted!')
    })
    onUpdated(() => {
      console.log('updated!')
    })
    onUnmounted(() => {
      console.log('unmounted!')
    })
  },
}
```

这些生命周期钩子注册函数只能在 `setup()` 期间同步使用， 因为它们依赖于内部的全局状态来定位当前组件实例（正在调用 `setup()` 的组件实例）, 不在当前组件下调用这些函数会抛出一个错误。

**与 2.x 版本生命周期相对应的组合式 API**

- ~~`beforeCreate`~~ -> 使用 `setup()`
- ~~`created`~~ -> 使用 `setup()`
- `beforeMount` -> `onBeforeMount`
- `mounted` -> `onMounted`
- `beforeUpdate` -> `onBeforeUpdate`
- `updated` -> `onUpdated`
- `beforeDestroy` -> `onBeforeUnmount`
- `destroyed` -> `onUnmounted`
- `errorCaptured` -> `onErrorCaptured`

**新增的钩子函数**

除了和 2.x 生命周期等效项之外，组合式 API 还提供了以下调试钩子函数：

- `onRenderTracked`
- `onRenderTriggered`

两个钩子函数都接收一个 `DebuggerEvent`

## 依赖注入

`provide` 和 `inject` 提供依赖注入，功能类似 2.x 的 `provide/inject`。两者都只能在当前活动组件实例的 `setup()` 中调用。

```js
import { provide, inject } from 'vue'

const ThemeSymbol = Symbol()

const Ancestor = {
  setup() {
    provide(ThemeSymbol, 'dark')
  },
}

const Descendent = {
  setup() {
    const theme = inject(ThemeSymbol, 'light' /* optional default value */)
    return {
      theme,
    }
  },
}
```

`inject` 接受一个可选的的默认值作为第二个参数。如果未提供默认值，并且在 provide 上下文中未找到该属性，则 `inject` 返回 `undefined`。

**注入的响应性**

可以使用 `ref` 来保证 `provided` 和 `injected` 之间值的响应：

```js
// 提供者：
const themeRef = ref('dark')
provide(ThemeSymbol, themeRef)

// 使用者：
const theme = inject(ThemeSymbol, ref('light'))
watchEffect(() => {
  console.log(`theme set to: ${theme.value}`)
})
```

如果注入一个响应式对象，则它的状态变化也可以被侦听。

## 模板 Refs

当使用组合式 API 时，*reactive refs* 和 *template refs* 的概念已经是统一的。为了获得对模板内元素或组件实例的引用，我们可以像往常一样在 `setup()` 中声明一个 ref 并返回它：

```html
<template>
  <div ref="rootRef">{{ b }}</div>
</template>

<script>
  import { ref, onMounted } from 'vue'

  export default {
    setup() {
      const rootRef = ref(null)
      cosnt b = ref(1)
      onMounted(() => {
        // 在渲染完成后, 这个 div DOM 会被赋值给 root ref 对象
        console.log(root.value) // <div/>
      })

      return {
        rootRef,
        b
      }
    },
  }
</script>
```

这里我们将 `root` 暴露在渲染上下文中，并通过 `ref="root"` 绑定到 `div` 作为其 `ref`。 在 Virtual DOM patch 算法中，如果一个 VNode 的 `ref` 对应一个渲染上下文中的 ref，则该 VNode 对应的元素或组件实例将被分配给该 ref。 这是在 Virtual DOM 的 mount / patch 过程中执行的，因此模板 ref 仅在渲染初始化后才能访问。

ref 被用在模板中时和其他 ref 一样：都是响应式的，并可以传递进组合函数（或从其中返回）。

**配合 render 函数 / JSX 的用法**

```js
export default {
  setup() {
    const root = ref(null)

    return () =>
      h('div', {
        ref: root,
      })

    // 使用 JSX
    return () => <div ref={root} />
  },
}
```

**在 `v-for` 中使用**

模板 ref 在 `v-for` 中使用 vue 没有做特殊处理，需要使用**函数型的 ref**（3.0 提供的新功能）来自定义处理方式：

```html
<template>
  <div v-for="(item, i) in list" :ref="el => { divs[i] = el }">
    {{ item }}
  </div>
</template>

<script>
  import { ref, reactive, onBeforeUpdate } from 'vue'

  export default {
    setup() {
      const list = reactive([1, 2, 3])
      const divs = ref([])

      // 确保在每次变更之前重置引用
      onBeforeUpdate(() => {
        divs.value = []
      })

      return {
        list,
        divs,
      }
    },
  }
</script>
```

## 响应式系统工具集

### `isRef`

检查一个值是否为一个 ref 对象。

### `unref`

如果参数是一个 ref 则返回它的 `value`，否则返回参数本身。它是 `val = isRef(val) ? val.value : val` 的语法糖。

### `toRef`

`toRef` 可以用来为一个 reactive 对象的属性创建一个 ref。这个 ref 可以被传递并且能够保持响应性。

```js
const state = reactive({
  foo: 1,
  bar: 2,
})

const fooRef = toRef(state, 'foo')

fooRef.value++
console.log(state.foo) // 2

state.foo++
console.log(fooRef.value) // 3
```

当您要将一个 prop 中的属性作为 ref 传给组合逻辑函数时，`toRef` 就派上了用场：

```js
export default {
  setup(props) {
    useSomeFeature(toRef(props, 'foo'))
  },
}
```

### `toRefs`

把一个响应式对象转换成普通对象，该普通对象的每个 property 都是一个 ref ，和响应式对象 property 一一对应。

```js
const state = reactive({
  foo: 1,
  bar: 2,
})

const stateAsRefs = toRefs(state)

// ref 对象 与 原属性的引用是 "链接" 上的
state.foo++
console.log(stateAsRefs.foo.value) // 2

stateAsRefs.foo.value++
console.log(state.foo) // 3
```

当想要从一个组合逻辑函数中返回响应式对象时，用 `toRefs` 是很有效的，该 API 让消费组件可以 解构 / 扩展（使用 `...` 操作符）返回的对象，并不会丢失响应性：

```js
function useFeatureX() {
  const state = reactive({
    foo: 1,
    bar: 2,
  })
  // 返回时将属性都转为 ref
  return toRefs(state)
}

export default {
  setup() {
    // 可以解构，不会丢失响应性
    const { foo, bar } = useFeatureX()

    return {
      foo,
      bar,
    }
  },
}
```

### `isProxy`

检查一个对象是否是由 `reactive` 或者 `readonly` 方法创建的代理。

### `isReactive`

检查一个对象是否是由 `reactive` 创建的响应式代理。



# 讨论点

### 代码组织

通过上面的API我们已经将组件的基于选项的 API 复制成了一些被导入的函数，但是这么做的目的是什么？用选项来定义组件看上去比用一个混入所有东西的大函数更具组织性！

但是实际上Composition API 实际上能够为你的代码带来*更*好组织结构，尤其是在复杂的组件中。

#### 有组织的代码

有组织的代码的最终目标应该是让代码更可读、更容易被理解。

当要去理解一个组件时，我们更加关心的是“这个组件是要干什么” (即代码背后的意图) 而不是“这个组件用到了什么选项”。基于选项的 API 撰写出来的代码自然采用了后者的表述方式，然而对前者的表述并不好。

#### 逻辑关注点 vs. 选项类型

我们不妨将组件处理的“X、Y 和 Z”定义为**逻辑关注点**。可读性的问题基本不会存在于小的、单一用途的组件中，因为整个组件都在处理同一个逻辑关注点。然而这个问题在复杂的用例中会变得突出。以 [Vue CLI UI 文件浏览器](https://github.com/vuejs/vue-cli/blob/a09407dd5b9f18ace7501ddb603b95e31d6d93c0/packages/@vue/cli-ui/src/components/folder/FolderExplorer.vue#L198-L404)为例，这个组件有非常多的逻辑关注点：

- 追踪监听当前文件夹的状态并展示其中的内容
- 处理文件夹的操作（打开、关闭、刷新...）
- 处理新建文件夹的创建
- 是否只展示收藏文件夹
- 是否只展示隐藏文件夹
- 处理当前工作目录的变化

你能通过阅读基于选项的代码直接梳理出各个逻辑关注点么？显然是十分困难的。你会发现到与各个逻辑关注点相关的代码是分散在各处的。

例如“创建新文件夹”的功能使用到了[两个数据 property](https://github.com/vuejs/vue-cli/blob/a09407dd5b9f18ace7501ddb603b95e31d6d93c0/packages/@vue/cli-ui/src/components/folder/FolderExplorer.vue#L221-L222)、[一个计算属性](https://github.com/vuejs/vue-cli/blob/a09407dd5b9f18ace7501ddb603b95e31d6d93c0/packages/@vue/cli-ui/src/components/folder/FolderExplorer.vue#L240)和[一个方法](https://github.com/vuejs/vue-cli/blob/a09407dd5b9f18ace7501ddb603b95e31d6d93c0/packages/@vue/cli-ui/src/components/folder/FolderExplorer.vue#L387)，而方法的定义在距离数据 property 约一百多行的位置。

如果我们对这些逻辑关注点进行染色，我们会注意到它们在用组件选项表示时是多么分散:

![file explorer (before)](https://wos2.58cdn.com.cn/iJkFeDcBiJiJ/rocket/9407bcca-bbc4-4c27-95ab-0ba35afe20b2.jpeg)

正是这种碎片化使得理解和维护一个复杂的组件变得非常困难。选项的强行分离为展示背后的逻辑关注点设置了障碍。此外，在处理单个逻辑关注点时，我们必须不断地在选项代码块之间“跳转”，以找到与该关注点相关的部分。

如果我们能够将相同逻辑关注点的代码并列在一起，那就再好不过了。这正是组合式 API 所能做到的，“创建新文件夹”功能可以这样写：

```js
function useCreateFolder(openFolder) {  // 组合函数建议使用 use 作为函数名的开头
  // 原来的数据 property
  const showNewFolder = ref(false)
  const newFolderName = ref('')

  // 原来的计算属性
  const newFolderValid = computed(() => isValidMultiName(newFolderName.value))

  // 原来的一个方法
  async function createFolder() {
    if (!newFolderValid.value) return
    const result = await mutate({
      mutation: FOLDER_CREATE,
      variables: {
        name: newFolderName.value,
      },
    })
    openFolder(result.data.folderCreate.path)
    newFolderName.value = ''
    showNewFolder.value = false
  }

  return {
    showNewFolder,
    newFolderName,
    newFolderValid,
    createFolder,
  }
}
```

此模式可用于该组件的所有其它逻辑关注点，最终成为一些良好解耦的函数:

![file explorer (comparison)](https://wos2.58cdn.com.cn/iJkFeDcBiJiJ/rocket/5b63f225-3fb3-43f0-9ba2-4737f4990a3f.jpeg)

每个逻辑关注点的代码现在都被组合进了一个组合函数。这大大减少了在处理大型组件时不断“跳转”的需要。同时组合函数也可以在编辑器中折叠起来，使组件更容易浏览:

```js
export default {
  setup() {
    // ...
  },
}

function useCurrentFolderData(networkState) {
  // ...
}

function useFolderNavigation({ networkState, currentFolderData }) {
  // ...
}

function useFavoriteFolder(currentFolderData) {
  // ...
}

function useHiddenFolders() {
  // ...
}

function useCreateFolder(openFolder) {
  // ...
}
```

同样的功能、两套组件定义呈现出对内在逻辑的不同的表达方式。基于选项的 API 促使我们通过 *选项类型* 组织代码，而组合式 API 让我们可以基于*逻辑关注点*组织代码。

### 与 React Hooks 相比

基于函数的组合式 API 提供了与 React Hooks 同等级别的逻辑组合能力，但是与它还是有很大不同：组合式 API 的 `setup()` 函数只会被调用一次，这意味着使用 Vue 组合式 API 的代码会是：

- 一般来说更符合惯用的 JavaScript 代码的直觉；
- 不需要顾虑调用顺序，也可以用在条件语句中；
- 不会在每次渲染时重复执行，以降低垃圾回收的压力；
- 不存在内联处理函数导致子组件永远更新的问题，也不需要 `useCallback`；
- 不存在忘记记录依赖的问题，也不需要“useEffect”和“useMemo”并传入依赖数组以捕获过时的变量。Vue 的自动依赖跟踪可以确保侦听器和计算值总是准确无误。

我们感谢 React Hooks 的创造性，它也是本提案的主要灵感来源，然而上面提到的一些问题存在于其设计之中，且我们发现 Vue 的响应式模型恰好为解决这些问题提供了一种思路。

### why-the-composition-api

- **Less code**（更少的代码）

- **Familiar functions**（熟悉的功能）

- **Extremely flexible**（极其灵活）

- **Tooling friendly**（工具友好）

- **Advanced syntax**（高级语法）

<p align="right">—引自Vue Mastery</p>

