## setState的流程
渲染的入口是 `preformSyncWorkOnRoot` 函数，`setState `修改完状态后，触发这个函数即可。

`setState` 会调用 `dispatchAction` , 创建一个 update 对象放到 `fiber` 节点的 `updateQueue` 上，然后调度渲染。

react 会先触发 update 的 `fiber` 往上找到 **根fiber** 节点，然后再调用 `performSyncWorkOnRoot` 的函数进行渲染

而 `setState` 是同步还是异步，也就是在这一段控制的。

在`scheduleUpdateOnFilber`更新函数中，有个判断条件里有个 `excutionContext` , 这个是用来标识当前环境的，比如是批量还是非批量，是否执行过 render 阶段，commit 阶段

在 `ReactDom.render` 执行的时候会先调用 `unBatchUpdate` 函数，这个函数会在 `excutionContext` 中设置一个 `unbatch` 的 flag, 这样在 update 的时候，就会立刻执行 `preformSyncWorkOnRoot` 来渲染，因为首次渲染的时候是要马上渲染的，没必要调度。

之后走到 `commit` 阶段会设置一个 `commit` 的 flag

然后再次 setState 就不会走到 unbatch 的分支了。

### 为什么 setTimeout 里面的 setState 会 同步执行呢？

因为直接从 setTimeout 执行的异步代码是没有设置 `excutionContext` 的， 那就会走到 NoContext 的分支，会立刻渲染。


### 参考链接： https://juejin.cn/post/7113535510894608414