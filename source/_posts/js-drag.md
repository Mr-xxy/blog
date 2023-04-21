---
title: js原生拖拽
id: 694
categories:
  - 技术分享
date: 2017-08-16 13:58:37
tags:
---

#### 原理

1.  鼠标按下：状态=1；记录鼠标的X和Y坐标；记录元素的X和Y偏移值
2.  鼠标在元素上移动：若状态=0，什么也不做；若状态为1，元素的新X的偏移量 = X2-X1+X(鼠标按下时的元素偏移)，新Y偏移量 = Y2-Y1+Y
3.  鼠标放开，状态=0

#### 在线预览

<p data-height="265" data-theme-id="0" data-slug-hash="oLVgvp" data-default-tab="js,result" data-user="abcdGJJ" data-embed-version="2" data-pen-title="oLVgvp" class="codepen">See the Pen <a href="https://codepen.io/abcdGJJ/pen/oLVgvp/">oLVgvp</a> by abcdGJJ (<a href="https://codepen.io/abcdGJJ">@abcdGJJ</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

<!-- more -->

#### 代码

```javascript
    var state = false;
    var obj, objLeft, objTop, posX, posY,wrap;
    window.onload = function() {
        obj = document.getElementById('drop');
        wrap = document.getElementById('wrap');
        obj.onmousedown = down;
        obj.onmousemove = move;
        obj.onmouseup = up;
    }
    function down(e) {
        obj.style.cursor = "move";
        state = true;
        objLeft = obj.offsetLeft;//obj左上角距离父节点左边距偏移像素值
        objTop = obj.offsetTop;
        posX = parseInt(getPostion(e).x);//鼠标位置
        posY = parseInt(getPostion(e).y);
    }
    function move(e) {
        if(state == true) {
            var x = parseInt(getPostion(e).x - posX + objLeft);
            var y = parseInt(getPostion(e).y - posY +objTop);
            var w = parseInt(wrap.clientWidth - obj.offsetWidth);
            var h = parseInt(wrap.clientHeight - obj.offsetHeight);
            // console.log(x,y);
            if(x < 0) {
                x = 0;
            } else if(x > w) {
                x = w;
            }
            if(y < 0) {
                y = 0;
            } else if(y > h) {
                y = h;
            }
            obj.style.left = x + 'px';
            obj.style.top = y +'px';
        }
    }
    function up() {
        state = false;
    }
    function getPostion(e) {
        var xpos, ypos;
        e = e || window.event;//浏览器兼容
        if(e.pageX) {
            xpos = e.pageX;
            ypos = e.pageY;
        } else {
            xpos = e.clientX + document.body.scrollLeft - document.body.clientLeft;
            ypos = e.clientY + document.body.scrollTop - document.body.clientTop;
        }
        return {
            x: xpos,
            y: ypos
        }
    }
```

#### 面向对象版本版本：

```javascript
function Drag(config) {
  this.target = document.getElementById(config.id) this.state = false
  if (config.parentElementId) {
    this.targetParent = document.getElementById(config.parentElementId)
    this.maxLeft = parseInt(this.targetParent.clientWidth - this.target.clientWidth)
    this.maxTop = parseInt(this.targetParent.clientHeight - this.target.clientHeight)
  } else {
    this.maxLeft = parseInt(document.documentElement.clientWidth - this.target.clientWidth) 
    this.maxTop = parseInt(document.documentElement.clientHeight - this.target.clientHeight)
  }
}
Drag.prototype = {
  constructor: Drag,
  start: function() {
    this.target.onmousedown = function(e) {
      this.down(e)
    }.bind(this)
    //或
    // var _this = this
    // this.target.onmousedown = function(e) {
    //     _this.down(e)
    // }
    this.target.onmousemove = function(e) {
      this.move(e)
    }.bind(this) this.target.onmouseup = function(e) {
      this.up(e)
    }.bind(this)
  },
  getPostion: function(e) {
    var posX, posY e = e || window.event
    if (e.pageX) {
      posX = e.pageX posY = e.pageY
    } else {
      posX = e.clientX + document.body.scrollLeft - document.body.clientLeft
      posY = e.clientY + document.body.scrollTop - document.body.clientTop
    }
    return {
      x: posX,
      y: posY
    }
  },
  down: function(e) {
    this.target.style.cursor = "move"
    this.state = true
    this.left = this.target.offsetLeft
    this.top = this.target.offsetTop
    this.posX = parseInt(this.getPostion(e).x)
    this.posY = parseInt(this.getPostion(e).y)
  },
  move: function(e) {
    if (this.state === true) {
      var x = parseInt(this.getPostion(e).x - this.posX + this.left)
      var y = parseInt(this.getPostion(e).y - this.posY + this.top) 
      if (x < 0) {
        x = 0
      } else if (x > this.maxLeft) {
        x = this.maxLeft
      }
      if (y < 0) {
        y = 0
      } else if (y > this.maxTop) {
        y = this.maxTop
      }
      this.target.style.left = x + 'px'this.target.style.top = y + 'px'
    }
  },
  up: function(e) {
    this.state = false
    // this.target.onmousedown = null
    // this.target.onmousemove = null
  }
}
```