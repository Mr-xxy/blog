---
title: javascript中Array中的indexOf方法
date: 2017-05-18 11:17:11
tags:
  - indexOf
categories:
  - 技术分享
---

#### 前言
想必`String`的`indexOf`方法大家都已经很熟悉，用来判断字符串中是否含有某个字符串片段，对于正则不熟悉的人可谓利器，这里不在赘述。但是`Array`的`indexOf`方法却很容易被大家忽略。
<!--more-->
#### 简述
**`Array.prototype.indexOf()`**
该indexOf()方法返回在数组中可以找到给定元素的第一个索引，如果不存在则返回-1。
![](http://www.leqikeji.cn/blogImg/Array.indexof.png)

#### 句法
	arr.indexOf（searchElement [，fromIndex]）
##### 参数
`searchElement`要在数组中找到的元素。
`fromIndex` *可选的*
开始搜索的索引。如果索引大于或等于数组的长度，则返回-1，这意味着数组将不会被搜索。如果提供的索引值是负数，则将其作为数组末尾的偏移量。注意：如果提供的索引是负数，则数组仍然是从前到后搜索。如果计算出的索引小于0，则将搜索整个数组。默认值：0（整个数组被搜索）。
##### 返回值
数组中元素的第一个索引; -1如果没有找到。

##### 描述
`indexOf()`与`searchElement`使用严格等式的数组的元素进行比较（与=== 三等于运算符使用的方法相同）即不会进行隐式类型转换。

#### 栗子
在数组中定位值。
```javascript
ar array = [2, 9, 9];
array.indexOf(2);     // 0
array.indexOf(7);     // -1
array.indexOf(9, 2);  // 2
array.indexOf(2, -1); // -1
array.indexOf(2, -3); // 0
```
****
查找元素所有位置
```javascript
var indices = [];
var array = ['a', 'b', 'a', 'c', 'a', 'd'];
var element = 'a';
var idx = array.indexOf(element);
while (idx != -1) {
  indices.push(idx);
  idx = array.indexOf(element, idx + 1);
}
console.log(indices);
// [0, 2, 4]
```
****
查找数组中是否存在元素并更新数组
```javascript
function updateVegetablesCollection (veggies, veggie) {
    if (veggies.indexOf(veggie) === -1) {
        veggies.push(veggie);
        console.log('New veggies collection is : ' + veggies);
    } else if (veggies.indexOf(veggie) > -1) {
        console.log(veggie + ' already exists in the veggies collection.');
    }
}

var veggies = ['potato', 'tomato', 'chillies', 'green-pepper'];

updateVegetablesCollection(veggies, 'spinach');
// New veggies collection is : potato,tomato,chillies,green-pepper,spinach
updateVegetablesCollection(veggies, 'spinach');
// spinach already exists in the veggies collection.
```
****

#### 兼容性
咱只说IE, 支持IE9以上