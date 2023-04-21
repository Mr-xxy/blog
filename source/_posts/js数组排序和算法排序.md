---
title: js 数组排序和算法排序
date: 2019-04-12 10:19:40
tags:
    -排序
categories:
    - 技术分享
---
### 概述
对所有的排序算法进行综合整理

<!--more-->
####  1.插入排序
##### 原理
>它的原理是每插入一个数都要将它和之前的已经完成排序的序列进行重新排序，也就是要找到新插入的数对应原序列中的位置。那么也就是说，每次插入一个数都要对原来排序好的那部分序列进行重新的排序，时间复杂度同样为O（n²）。 这种算法是稳定的排序方法。

##### 图解
![](http://www.leqikeji.cn/blogImg/charupaixu.gif)
```javascript
var arr = [23,34,3,4,23,44,333,444];

var arrShow = (function insertionSort(array){
    if(Object.prototype.toString.call(array).slice(8,-1) ==='Array'){

    for (var i = 1; i < array.length; i++) {
        var key = array[i];
        var j = i - 1;
        while (j >= 0 && array[j] > key) {
            array[j + 1] = array[j];
            j--;
        }
        array[j + 1] = key;
    }
        return array;
    }else{
        return 'array is not an Array!';
    }
})(arr);

console.log(arrShow);//[3, 4, 23, 23, 34, 44, 333, 444]

```

#### 2.二分插入排序
##### 算法思想
>1.二分插入排序的基本思想和插入排序一致；都是将某个元素插入到已经有序的序列的正确的位置；

>2.和直接插入排序的最大区别是，元素A[i]的位置的方法不一样；直接插入排序是从A[i-1]往前一个个比较，从而找到正确的位置；而二分插入排序，利用前i-1个元素已经是有序的特点结合二分查找的特点，找到正确的位置，从而将A[i]插入，并保持新的序列依旧有序；

>3.时间复杂度：T(n) = O(n);
```javascript
function binaryInsertionSort(array) {
    if (Object.prototype.toString.call(array).slice(8, -1) === 'Array') {
    for (var i = 1; i < array.length; i++) {
        var key = array[i], left = 0, right = i - 1;
        while (left <= right) {
            var middle = parseInt((left + right) / 2);
            if (key < array[middle]) {
                right = middle - 1;
            } else {
                left = middle + 1;
            }
        }
        for (var j = i - 1; j >= left; j--) {
            array[j + 1] = array[j];
        }
        array[left] = key;
    }
        return array;
    } else {
        return 'array is not an Array!';
    }
}
```

#### 3.选择排序
##### 工作原理
>它的工作原理是每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完。

##### 图解
![](http://www.leqikeji.cn/blogImg/xuanzepaixu.jpeg)
选择排序就是对数组中的元素进行比较选择，然后直接放置在排序后的位置。 
首先指针K先指向数组0号位置，K相当于指明一个目标位置。然后另一个指针min从K开始，往后一次比较，找到最小的值，并存储在min中，比较了一轮后，min中存储的数就是整个数组中最小的数字。这是直接将min中的数字和K指向的数字交换即可。然后找到数组中第二小的数，让他跟数组中第二个元素交换一下值，以此类推。
```javascript
function selectionSort(array) {
    if (Object.prototype.toString.call(array).slice(8, -1) === 'Array') {
        var len = array.length, temp;
        for (var i = 0; i < len - 1; i++) {
            var min = array[i];
            for (var j = i + 1; j < len; j++) {
                if (array[j] < min) {
                    temp = min;
                    min = array[j];
                    array[j] = temp;
                }
            }
            array[i] = min;
        }
        return array;
    } else {
        return 'array is not an Array!';
    }
}
```

#### 4.冒泡排序

>原理：比较两个相邻的元素，将值大的元素交换至右端。

>思路：依次比较相邻的两个数，将小数放在前面，大数放在后面。即在第一趟：首先比较第1个和第2个数，将小数放前，大数放后。然后比较第2个数和第3个数，将小数放前，大数放后，如此继续，直至比较最后两个数，将小数放前，大数放后。重复第一趟步骤，直至全部排序完成。
```javascript
function bubbleSort(array) {
    if (Object.prototype.toString.call(array).slice(8, -1) === 'Array') {
        var len = array.length, temp;
        for (var i = 0; i < len - 1; i++) {
            for (var j = len - 1; j >= i; j--) {
                if (array[j] < array[j - 1]) {
                    temp = array[j];
                    array[j] = array[j - 1];
                    array[j - 1] = temp;
                }
            }
        }
        return array;
    } else {
        return 'array is not an Array!';
    }
}
```

#### 5.快速排序
##### 基本思想
>基本思想是：通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。

##### 算法介绍
![](https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D220/sign=2785ee7e918fa0ec7bc7630f1696594a/b7003af33a87e950707fdf2110385343fbf2b416.jpg)
设要排序的数组是A[0]……A[N-1]，首先任意选取一个数据（通常选用数组的第一个数）作为关键数据，然后将所有比它小的数都放到它左边，所有比它大的数都放到它右边，这个过程称为一趟快速排序。值得注意的是，快速排序不是一种稳定的排序算法，也就是说，多个相同的值的相对位置也许会在算法结束时产生变动。
一趟快速排序的算法是：
1）设置两个变量i、j，排序开始的时候：i=0，j=N-1；
2）以第一个数组元素作为关键数据，赋值给key，即key=A[0]；
3）从j开始向前搜索，即由后开始向前搜索(j--)，找到第一个小于key的值A[j]，将A[j]和A[i]的值交换；
4）从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于key的A[i]，将A[i]和A[j]的值交换；
5）重复第3、4步，直到i=j； (3,4步中，没找到符合条件的值，即3中A[j]不小于key,4中A[i]不大于key的时候改变j、i的值，使得j=j-1，i=i+1，直至找到为止。找到符合条件的值，进行交换的时候i， j指针位置不变。另外，i==j这一过程一定正好是i+或j-完成的时候，此时令循环结束）。
```javascript
//方法一
function quickSort(array, left, right) {
    if (Object.prototype.toString.call(array).slice(8, -1) === 'Array' && typeof left === 'number' && typeof right === 'number') {
        if (left < right) {
            var x = array[right], i = left - 1, temp;
            for (var j = left; j <= right; j++) {
                if (array[j] <= x) {
                    i++;
                    temp = array[i];
                    array[i] = array[j];
                    array[j] = temp;
                }
            }
            quickSort(array, left, i - 1);
            quickSort(array, i + 1, right);
        };
    } else {
        return 'array is not an Array or left or right is not a number!';
    }
}
var aaa = [3, 5, 2, 9, 1];
quickSort(aaa, 0, aaa.length - 1);
console.log(aaa);
    
    
//方法二
var quickSort = function(arr) {
　　if (arr.length <= 1) { return arr; }
　　var pivotIndex = Math.floor(arr.length / 2);
　　var pivot = arr.splice(pivotIndex, 1)[0];
　　var left = [];
　　var right = [];
　　for (var i = 0; i < arr.length; i++){
　　　　if (arr[i] < pivot) {
　　　　　　left.push(arr[i]);
　　　　} else {
　　　　　　right.push(arr[i]);
　　　　}
　　}
　　return quickSort(left).concat([pivot], quickSort(right));
};
```

#### 6.堆排序
```javascript
/*方法说明：堆排序
@param array 待排序数组*/
function heapSort(array) {
    if (Object.prototype.toString.call(array).slice(8, -1) === 'Array') {
        //建堆
        var heapSize = array.length, temp;
        for (var i = Math.floor(heapSize / 2); i >= 0; i--) {
            heapify(array, i, heapSize);
        }
        
        //堆排序
        for (var j = heapSize - 1; j >= 1; j--) {
            temp = array[0];
            array[0] = array[j];
            array[j] = temp;
            heapify(array, 0, --heapSize);
        }
    } else {
        return 'array is not an Array!';
    }
}
/*方法说明：维护堆的性质
@param arr 数组
@param x 数组下标
@param len 堆大小*/
function heapify(arr, x, len) {
    if (Object.prototype.toString.call(arr).slice(8, -1) === 'Array' && typeof x === 'number') {
        var l = 2 * x, r = 2 * x + 1, largest = x, temp;
        if (l < len && arr[l] > arr[largest]) {
            largest = l;
        }
        if (r < len && arr[r] > arr[largest]) {
            largest = r;
        }
        if (largest != x) {
            temp = arr[x];
            arr[x] = arr[largest];
            arr[largest] = temp;
            heapify(arr, largest, len);
        }
    } else {
        return 'arr is not an Array or x is not a number!';
    }
}
```

#### 7.归并排序
```javascript
function mergeSort(array, p, r) {
    if (p < r) {
        var q = Math.floor((p + r) / 2);
        mergeSort(array, p, q);
        mergeSort(array, q + 1, r);
        merge(array, p, q, r);
    }
}
function merge(array, p, q, r) {
    var n1 = q - p + 1, n2 = r - q, left = [], right = [], m = n = 0;
    for (var i = 0; i < n1; i++) {
        left[i] = array[p + i];
    }
    for (var j = 0; j < n2; j++) {
        right[j] = array[q + 1 + j];
    }
    left[n1] = right[n2] = Number.MAX_VALUE;
    for (var k = p; k <= r; k++) {
        if (left[m] <= right[n]) {
            array[k] = left[m];
            m++;
        } else {
            array[k] = right[n];
            n++;
        }
    }
}
```

#### 8.桶排序
```javascript
/*方法说明：桶排序
@param array 数组
@param num 桶的数量*/
function bucketSort(array, num) {
    if (array.length <= 1) {
        return array;
    }
    var len = array.length, buckets = [], result = [], min = max = array[0], regex = '/^[1-9]+[0-9]*$/', space, n = 0;
    num = num || ((num > 1 && regex.test(num)) ? num : 10);
    for (var i = 1; i < len; i++) {
        min = min <= array[i] ? min : array[i];
        max = max >= array[i] ? max : array[i];
    }
    space = (max - min + 1) / num;
    for (var j = 0; j < len; j++) {
        var index = Math.floor((array[j] - min) / space);
        if (buckets[index]) { // 非空桶，插入排序
            var k = buckets[index].length - 1;
            while (k >= 0 && buckets[index][k] > array[j]) {
                buckets[index][k + 1] = buckets[index][k];
                k--;
            }
            buckets[index][k + 1] = array[j];
        } else { //空桶，初始化
            buckets[index] = [];
            buckets[index].push(array[j]);
        }
    }
    while (n < num) {
        result = result.concat(buckets[n]);
        n++;
    }
    return result;
}
```

#### 9.计数排序
```javascript
function countingSort(array) {
    var len = array.length, B = [], C = [], min = max = array[0];
    for (var i = 0; i < len; i++) {
        min = min <= array[i] ? min : array[i];
        max = max >= array[i] ? max : array[i];
        C[array[i]] = C[array[i]] ? C[array[i]] + 1 : 1;
    }
    for (var j = min; j < max; j++) {
        C[j + 1] = (C[j + 1] || 0) + (C[j] || 0);
    }
    for (var k = len - 1; k >=0; k--) {
        B[C[array[k]] - 1] = array[k];
        C[array[k]]--;
    }
    return B;
}
```
