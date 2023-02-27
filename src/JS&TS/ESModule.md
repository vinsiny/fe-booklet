## 1. 模块历史
amd(async module definition)、cmd(common module definition) 社区提供的 js 模块语言规范(逐渐淘汰)；
commonjs => nodejs的内置模块
esmodule => js/es 的语言模块规范

## 2. es module
大部分浏览器支持 es module，成为事实上 js 模块规范
### 2.1 module script 标签注意点
1. script 标签使用时，方式如下：
```js
<script type="module">
  var str = 'hello';
</script>
```
2. 模块内默认是严格模式；
3. 模块内变量是单独作用域，其他模块无法直接使用；
4. `type=module` 标签的script脚本默认带有 `defer` 属性，即延迟执行，不阻塞 html 结构解析，加载完成后执行对应脚本；
5. esm 通过 cors 方式请求的，需要server 端支持cors；
```js
// baidu cdn 不支持跨域请求，会报跨域错误
<script type="module" src="https://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
// unpkg 支持cors，可以正常下载
<script type="module" src="https://unpkg.com/jquery@3.4.1/dist/jquery.min.js"></script>
```

### 2.2 esm 导入导出注意点
1. 导入的是变量的应用
```js
// module.js
export var foo ='hello';
setTimeout(function() {
  foo = 'world';
}, 1000);
// app.js
import { foo } from './module.js';
console.log(foo); // hello
setTimeout(function() {
  console.log(foo); // world
}, 1000);
```
2. 导入的成员是不可变变量，即约等于声明了 `const foo`
```js
// module.js
export var foo ='hello';
// app.js
import { foo } from './module.js';
console.log(foo); // hello

foo = 'world'; // error
```

3. `export { xx, xxx }` 是一种esm 语法，不等于对象结构语法
```js
// module.js
var foo ='hello';
var bar = 'bar str';

export { bar, foo }; // 默认语法
var obj = {
  foo, bar
}
export obj; // 导出 obj 对象，两者不同
```

