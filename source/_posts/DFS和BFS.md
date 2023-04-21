---
title: DFS和BFS小结
date: 2020-04-08 16:40:32
tags:
    - dfs
    - bfs
categories:
    - 技术分享

---

**DFS（Deep First Search）深度优先遍历。**

**BFS（Breath First Search）广度优先遍历。**
<!-- more -->

## 1.DFS（深度优先遍历）

**深度优先遍历的步骤分为 1.递归下去 2.回溯上来。顾名思义，深度优先，则是以深度为准则，先一条路走到底，直到达到目标。**

**否则既没有达到目标又无路可走了，那么则退回到上一步的状态，走其他路。这便是回溯上来。**

##### DFS模板

```javascript
function dfs() {
    if(到达终点状态)  {  
        //... 根据题意添加  
        return;  
    }  
    if(越界或者是不合法状态)  
        return;  
    if(特殊状态)//剪枝
        return ;
    for(扩展方式)  {  
        if(扩展方式所达到状态合法)  {  
            修改操作;//根据题意来添加  
            标记；  
            dfs（）；  
            (还原标记)；  
            //是否还原标记根据题意  
            //如果加上（还原标记）就是 回溯法  
        }  
    }  
}  
```

## 2.BFS（广度优先遍历）

广度优先遍历较之深度优先遍历之不同在于，深度优先遍历旨在不管有多少条岔路，先一条路走到底，不成功就返回上一个路口然后就选择下一条岔路，而广度优先遍历旨在面临一个路口时，把所有的岔路口都记下来，然后选择其中一个进入，然后将它的分路情况记录下来，然后再返回来进入另外一个岔路，并重复这样的操作

##### BFS模板

```javascript
function BFS(s) {
    let queue = [s];
    while(queue.length) {
        const top = queue.shift()
        //取出队首元素top并出队;    
        //...
        //访问队首元素top操作;
        //将top的下一层结点中未曾入队的结点全部入队，并设置为已入队; 
    }
} 
```

## 3. 案例

#### 3.1机器人的运动范围

地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？

示例 1：

> 输入：m = 2, n = 3, k = 1
> 输出：3

示例 2：

> 输入：m = 3, n = 1, k = 0
> 输出：1

提示：

> 1 <= n,m <= 100
> 0 <= k <= 20

**思路：**如果我们直接遍历检查所有的点，取出满足数位相加之和的条件，机器人不一定可以达到。例如当 m=38，n=15，k=9 时，由于只能向合法坐标移动 1 格，从`(18,0)`并不能到达`(20, 0)`，即使`(20, 0)`满足数位之和的条件。

所以我们应当采用DFS或者BFS的思想来处理

##### 解法1 DFS

```javascript
const bitSum = (num) => String(num).split('').reduce((_t, _n)=> (Number(_t) + Number(_n)), 0)

var movingCount = function(m, n, k) {
    let res = 0;
    const directions = [
        [-1, 0],
        [1, 0],
        [0, -1],
        [0, 1]
    ];
    const visited = {};
    dfs(0, 0);
    return res;

    function dfs(x, y) {
        visited[`${x}-${y}`] = true;
        if (bitSum(x) + bitSum(y) > k) {
            return;
        }
        ++res;

        for (const direction of directions) {
            const newx = direction[0] + x;
            const newy = direction[1] + y;
            if (
                !visited[`${newx}-${newy}`] &&
                newx >= 0 &&
                newy >= 0 &&
                newx < m &&
                newy < n
            ) {
                dfs(newx, newy);
            }
        }
    }
};
```

##### 解法2 BFS

```javascript
var movingCount = function(m, n, k) {
    let res = 0;
    const directions = [
        [1, 0],
        [0, 1]
    ];
    const queue = [[0, 0]];
    const visited = {
        "0-0": true
    };

    while (queue.length) {
        const [x, y] = queue.shift();
        
        if (bitSum(x) + bitSum(y) > k) {
            continue;
        }
        ++res;

        for (const direction of directions) {
            const newx = direction[0] + x;
            const newy = direction[1] + y;
            if (
                !visited[`${newx}-${newy}`] &&
                newx >= 0 &&
                newy >= 0 &&
                newx < m &&
                newy < n
            ) {
                queue.push([newx, newy]);
                visited[`${newx}-${newy}`] = true;
            }
        }
    }

    return res;
};
```



## 4.总结

对于这两个遍历方法，其实我们是可以轻松的看出来，他们有许多差异与许多相同点的。

**1.数据结构上的运用**

DFS用递归的形式，用到了栈结构，先进后出。

BFS选取状态用队列的形式，先进先出。

**2.复杂度**

DFS的复杂度与BFS的复杂度大体一致，不同之处在于遍历的方式与对于问题的解决出发点不同，DFS适合目标明确，而BFS适合大范围的寻找。

**3.思想**

思想上来说这两种方法都是穷竭列举所有的情况。