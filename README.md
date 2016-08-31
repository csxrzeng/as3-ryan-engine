基于AS3的（游戏）程序框架。

主要功能：
1. 定时器管理
2. 播放器封装
3. 资源管理
4. 工具类
5. 键盘按键管理类

使用方法：
初始化：Global.instance().initStage(stage);

定时器部分：
原理，使用一个定时器去管理多个定时器，防止创建太多定时器导致性能下降的问题。

帧定时器：每隔delay帧执行一次回调，最小化的时候会减帧
var timer:FrameTime = new FrameTimer(delay:int = 1, repeatCount:int = int.MAX_VALUE);
timer.addListener(TimerType.ENTERFRAME, this.onTimerEnterFrame);
timer.addListener(TimerType.COMPLETE, this.onTimerComplete);
timer.start();

秒定时器：每隔delay秒执行一次回调
var secTimer:SecTimer = new SecTimer(delay:int = 1, repeatCount:int = int.MAX_VALUE);

毫秒定时器：每隔delay秒执行一次回调，效率一般，尽量少用。
var mTimer:MSecTimer = new MSecTimer(delay:int = 1, repeatCount:int = int.MAX_VALUE);

播放器：
分为两种：一种为BitmapPlayer，一种为MoviePlayer。前者使用位图进行每一帧的渲染，后者直接gotoAndStop进行渲染。
在游戏程序中，主要使用EffectPlayer或FastEffectPlayer进行模型的渲染播放。两者的区别是后者在添加到舞台的时候会自动播放，从舞台移除的时候会自动停止播放。
而一些比较大的特效，为了缩小下载的体积，为了限制内存占用，使用MoviePlayer或SlowEffectPlayer按影片剪辑的方式进行播放。区别同上

资源管理：
LoaderManager对资源的加载进行了封装，提高了可靠性。加入了加载优先级功能。
SharedManager则把加载的资源存入SharedObject缓存起来，避免多次加载。

工具类：
ObjectPool：对象池，提供对象的回收与获取接口，减轻垃圾回收的负担，优化程序性能。
StringTools：封装了一些优化的字符串处理函数
MathUtil：封装了角度计算相关等一些常用的函数

键盘按键管理：
对键盘按键事件进行全局的处理，并通过KeyCode提供常用的按键常量。

TrianglesFall: 位图三角形切块掉落的效果，用于角色死亡效果。
