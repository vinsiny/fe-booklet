## type 和 interface 的区别
官方文档对二者的说明：
> - An interface can be named in an extends or implements clause, but a type alias for an object type literal cannot.
> - An interface can have multiple merged declarations, but a type alias for an object type literal cannot.

### 相同点
- 都可以描述一个对象或者函数；
- 都允许拓展（extends），两者语法存在一定差异

```ts
// base interface
interface IName { 
  name: string; 
}
// base type
type TName = = { 
  name: string; 
}
// interface extends interface
interface IUser extends IName { 
  age: number; 
}
// type extends type
type TUser = TName & { age: number  };
// interface extends type
interface IUser extends TName { 
  age: number; 
}
// type extends interface
type TUser = IName & { 
  age: number; 
}
```

### 不同点
#### 1. type 可以而 interface 不行

- type 可以声明基本类型别名、联合类型、元组等类型；
```ts
// 1. 基本类型别名
type Name = string
// 2. 联合类型
interface Dog {
    wong();
}
interface Cat {
    miao();
}
type Pet = Dog | Cat
// 3. 具体定义数组每个位置的类型，元组
type PetList = [Dog, Pet]
```
- type 语句中还可以使用 `typeof` 获取实例的类型进行赋值
```ts
// 当你想获取一个变量的类型时，使用 typeof
let div = document.createElement('div');
type B = typeof div
```

#### 2. interface 可以而 type 不行
- interface 能够声明合并
```ts
interface User {
  name: string
  age: number
}

interface User {
  sex: string
}

/*
User 接口为 {
  name: string
  age: number
  sex: string 
}
*/
```
### 总结
一般来说，如果不清楚什么时候用interface/type，能用 interface 实现，就用 interface , 如果不能就用 type；

## unknow 和 any 的区别

### any
- 任何类型都可以被归为 any 类型，any 是顶级类型（也被称作全局超级类型）；
- any 类型本质上是类型系统的一个逃逸舱，TypeScript 允许我们对 any 类型的值执行任何操作，而无需事先执行任何形式的检查；

### unknow
- 所有类型也都可以赋值给 unknown；
- unknown 类型只能被赋值给 any 类型和 unknown 类型本身（这是有道理的：只有能够保存任意类型值的容器才能保存 unknown 类型的值。毕竟我们不知道变量 value 中存储了什么类型的值）；
- 将 value 变量类型设置为 unknown 后，这些操作都不再被认为是类型正确的。通过将 any 类型改变为 unknown 类型，我们已将允许所有更改的默认设置，更改为禁止任何更改。
```ts
let value: unknown;

value.foo.bar; // Error
value.trim(); // Error
value(); // Error
new value(); // Error
value[0][1]; // Error
```
