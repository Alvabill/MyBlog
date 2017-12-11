<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <p>Electron 是一个搭建跨平台桌面应用的框架，仅仅使用 JavaScript、HTML 以及 CSS，即可快速而容易地搭建一个原生应用。这对于想要涉及其他领域的开发者来说是一个非常大的福利。</p>
                  <a id="more"></a>
                  <h2 id="项目介绍">
                    <a href="#项目介绍" class="headerlink" title="项目介绍"></a>项目介绍</h2>
                  <p>仓库地址：<a href="https://github.com/lin-xin/calculator" target="_blank" rel="external">lin-xin/calculator</a>
                  </p>
                  <p>我这里通过 Electron 实现了仿 iPhone 的计算器，通过菜单可以切换横屏和竖屏，横屏有更多的运算。而对于 JavaScript 进行浮点数计算来说，精度丢失是个很大问题，所以我这里使用了第三方库 math.js 来解决这个精度的问题。<br>尽可能的实现了跟 iPhone 一样的运算：</p>
                    <ul>
                      <li>1 + 2 × 3 = 7</li>
                      <li>3 += 6 (再按 = 等于 9)</li>
                      <li>0.1 + 0.2 = 0.3 (浮点数精度处理)</li>
                    </ul>
                    <p>
                      <img src="https://github.com/lin-xin/calculator/raw/master/screenshot/calc1.jpg?123" alt="Image text">
                        <br>
                          <img src="https://github.com/lin-xin/calculator/raw/master/screenshot/calc2.jpg" alt="Image text"></p>
                          <p>不过我下面并不是要讲计算器，而是用到的 Electron 的知识点。</p>
                          <h2 id="生命周期">
                            <a href="#生命周期" class="headerlink" title="生命周期"></a>生命周期</h2>
                          <p>在主进程中通过 app 模块控制整个应用的生命周期。</p>
                          <p>当 Electron 完成初始化时触发 ready 事件：</p>
                          <figure class="highlight js">
                            <table>
                              <tbody>
                                <tr>
                                  <td class="gutter">
                                    <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div></pre>
                                  </td>
                                  <td class="code">
                                    <pre><div class="line">app.on(<span class="string">'ready'</span>, () =&gt; {</div><div class="line">    <span class="comment">// 创建窗口、加载页面等操作</span></div><div class="line">})</div></pre>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </figure>
                          <p>当所有的窗口都被关闭时会触发 window-all-closed 事件：<br></p>
                            <figure class="highlight js">
                              <table>
                                <tbody>
                                  <tr>
                                    <td class="gutter">
                                      <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div></pre>
                                    </td>
                                    <td class="code">
                                      <pre><div class="line">app.on(<span class="string">'window-all-closed'</span>, () =&gt; {</div><div class="line">    <span class="keyword">if</span>(process.platform !== <span class="string">'darwin'</span>){</div><div class="line">        app.quit();     <span class="comment">// 退出应用</span></div><div class="line">    }</div><div class="line">})</div></pre>
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                            </figure>
                            <p></p>
                            <p>在开发中发现，没有监听该事件，打包后的应用关闭后，进程还保留着，会占用系统的内存。</p>
                            <h2 id="窗口">
                              <a href="#窗口" class="headerlink" title="窗口"></a>窗口</h2>
                            <p>本来我们的 html 只显示在浏览器中，而 electron 提供了一个 BrowserWindow 模块用于创建和控制浏览器窗口，我们的页面就是显示在这样的窗口中。</p>
                            <h3 id="创建窗口">
                              <a href="#创建窗口" class="headerlink" title="创建窗口"></a>创建窗口</h3>
                            <p>通过关键字 new 实例化返回 win 对象，该对象有丰富的方法对窗口进行控制。<br></p>
                              <figure class="highlight js">
                                <table>
                                  <tbody>
                                    <tr>
                                      <td class="gutter">
                                        <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div></pre>
                                      </td>
                                      <td class="code">
                                        <pre><div class="line">win = <span class="keyword">new</span> BrowserWindow({</div><div class="line">    <span class="attr">width</span>: <span class="number">390</span>,         <span class="comment">// 窗口宽度</span></div><div class="line">    height: <span class="number">670</span>,        <span class="comment">// 窗口高度</span></div><div class="line">    fullscreen: <span class="literal">false</span>,  <span class="comment">// 不允许全屏</span></div><div class="line">    resizable: <span class="literal">false</span>    <span class="comment">// 不允许改变窗口size，不然布局就乱了啊</span></div><div class="line">});</div></pre>
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                              </figure>
                              <p></p>
                              <h3 id="加载页面">
                                <a href="#加载页面" class="headerlink" title="加载页面"></a>加载页面</h3>
                              <p>窗口创建完是一片空白的，可以通过 win.loadURL() 来加载要显示的页面。</p>
                              <figure class="highlight js">
                                <table>
                                  <tbody>
                                    <tr>
                                      <td class="gutter">
                                        <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div><div class="line">8</div></pre>
                                      </td>
                                      <td class="code">
                                        <pre><div class="line"><span class="keyword">const</span> path = <span class="built_in">require</span>(<span class="string">'path'</span>);</div><div class="line"><span class="keyword">const</span> url = <span class="built_in">require</span>(<span class="string">'url'</span>);</div><div class="line"></div><div class="line">win.loadURL(url.format({    <span class="comment">// 加载本地的文件</span></div><div class="line">    pathname: path.join(__dirname, <span class="string">'index.html'</span>),</div><div class="line">    <span class="attr">protocol</span>: <span class="string">'file'</span>,</div><div class="line">    <span class="attr">slashes</span>: <span class="literal">true</span></div><div class="line">}))</div></pre>
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                              </figure>
                              <p>也可以直接加载远程链接 win.loadURL(‘<a href="http://blog.gdfengshuo.com">http://blog.gdfengshuo.com</a>‘);</p>
                              <h2 id="菜单">
                                <a href="#菜单" class="headerlink" title="菜单"></a>菜单</h2>
                              <p>桌面应用菜单栏是最常见的功能。Electron 提供了 Menu 模块来创建原生的应用菜单和 context 菜单，<br></p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div><div class="line">8</div><div class="line">9</div><div class="line">10</div><div class="line">11</div><div class="line">12</div><div class="line">13</div><div class="line">14</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> template = [                              <span class="comment">// 创建菜单模板</span></div><div class="line">    {</div><div class="line">        <span class="attr">label</span>: <span class="string">'查看'</span>,</div><div class="line">        <span class="attr">submenu</span>: [</div><div class="line">            {<span class="attr">label</span>: <span class="string">'竖屏'</span>, <span class="attr">type</span>: <span class="string">'radio'</span>, <span class="attr">checked</span>: <span class="literal">true</span>},      <span class="comment">// type 属性让菜单为 radio 可选</span></div><div class="line">            {<span class="attr">label</span>: <span class="string">'横屏'</span>, <span class="attr">type</span>: <span class="string">'radio'</span>, <span class="attr">checked</span>: <span class="literal">false</span>},</div><div class="line">            {<span class="attr">label</span>: <span class="string">'重载'</span>,<span class="attr">role</span>:<span class="string">'reload'</span>},</div><div class="line">            {<span class="attr">label</span>: <span class="string">'退出'</span>,<span class="attr">role</span>:<span class="string">'quit'</span>},</div><div class="line">        ]</div><div class="line">    }</div><div class="line">]</div><div class="line"></div><div class="line"><span class="keyword">const</span> menu = Menu.buildFromTemplate(template);  <span class="comment">// 通过模板返回菜单的数组</span></div><div class="line">Menu.setApplicationMenu(menu);                  <span class="comment">// 将该数组设置为菜单</span></div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <p></p>
                                <p>在子菜单中，通过点击竖屏或横屏来进行一些操作，那就可以给 submenu 监听 click 事件。</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div><div class="line">8</div><div class="line">9</div><div class="line">10</div><div class="line">11</div><div class="line">12</div><div class="line">13</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> template = [</div><div class="line">    {</div><div class="line">        <span class="attr">label</span>: <span class="string">'查看'</span>,</div><div class="line">        <span class="attr">submenu</span>: [</div><div class="line">            {</div><div class="line">                <span class="attr">label</span>: <span class="string">'横屏'</span></div><div class="line">                click: <span class="function"><span class="params">()</span> =&gt;</span> {              <span class="comment">// 监听横屏的点击事件</span></div><div class="line">                    win.setSize(<span class="number">670</span>,<span class="number">460</span>);   <span class="comment">// 设置窗口的宽高</span></div><div class="line">                }</div><div class="line">            }</div><div class="line">        ]</div><div class="line">    }</div><div class="line">]</div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <h2 id="主进程和渲染进程通信">
                                  <a href="#主进程和渲染进程通信" class="headerlink" title="主进程和渲染进程通信"></a>主进程和渲染进程通信</h2>
                                <p>虽然点击横屏的时候，可以设置窗口的宽高，但是要如何去触发页面里的方法，这里就需要主进程跟渲染进程之间进行通信。</p>
                                <p>主进程，可以理解为 main.js 用来写 electron api 的就是主进程，渲染进程就是渲染出来的页面。</p>
                                <h3 id="ipcMain">
                                  <a href="#ipcMain" class="headerlink" title="ipcMain"></a>ipcMain</h3>
                                <p>在主进程中可以使用 ipcMain 模块，它控制着由渲染进程(web page)发送过来的异步或同步消息。</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> {ipcMain} = <span class="built_in">require</span>(<span class="string">'electron'</span>)</div><div class="line">ipcMain.on(<span class="string">'send-message'</span>, (event, arg) =&gt; {</div><div class="line">    event.sender.send(<span class="string">'reply-message'</span>, <span class="string">'hello world'</span>)</div><div class="line">})</div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <p>ipcMain 监听 send-message 事件，当消息到达时可以调用 event.sender.send 来回复异步消息，向渲染进程发送 reply-message 事件，也可以带着参数发送过去。</p>
                                <h3 id="ipcRenderer">
                                  <a href="#ipcRenderer" class="headerlink" title="ipcRenderer"></a>ipcRenderer</h3>
                                <p>在渲染进程可以调用 ipcRenderer 模块向主进程发送同步或异步消息，也可以收到主进程的相应。</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> {ipcRenderer} = <span class="built_in">require</span>(<span class="string">'electron'</span>)</div><div class="line">ipcRenderer.on(<span class="string">'reply-message'</span>, (event, arg) =&gt; {</div><div class="line">    <span class="built_in">console</span>.log(arg);       <span class="comment">// hello world</span></div><div class="line">})</div><div class="line"></div><div class="line">ipcRenderer.send(<span class="string">'anything'</span>, <span class="string">'hello everyone'</span>);</div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <p>ipcRenderer 可以监听到来自主进程的 reply-message 事件并拿到参数进行操作，也可以使用 send() 方法向主进程发送消息。</p>
                                <h3 id="webContents">
                                  <a href="#webContents" class="headerlink" title="webContents"></a>webContents</h3>
                                <p>webContents 是一个事件发出者，它负责渲染并控制网页，也是 BrowserWindow 对象的属性。在 ipcMain 中的 event.sender，返回发送消息的 webContents 对象，所以包含着 send() 方法用于发送消息。</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> win = BrowserWindow.fromId(<span class="number">1</span>);        <span class="comment">// fromId() 方法找到ID为1的窗口</span></div><div class="line">win.webContents.on(<span class="string">'todo'</span>, () =&gt; {</div><div class="line">    win.webContents.send(<span class="string">'done'</span>, <span class="string">'well done!'</span>)</div><div class="line">})</div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <h3 id="remote">
                                  <a href="#remote" class="headerlink" title="remote"></a>remote</h3>
                                <p>remote 模块提供了一种在渲染进程（网页）和主进程之间进行进程间通讯（IPC）的简便途径。在 Electron 中，有许多模块只存在主进程中，想要调用这些模块的方法需要通过 ipc 模块向主进程发送消息，让主进程调用这些方法。而使用 remote 模块，则可以在渲染进程中调用这些只存在于主进程对象的方法了。</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> {remote} = <span class="built_in">require</span>(<span class="string">'electron'</span>)</div><div class="line"><span class="keyword">const</span> BrowserWindow = remote.BrowserWindow      <span class="comment">// 访问主进程中的BrowserWindow模块</span></div><div class="line"></div><div class="line"><span class="keyword">let</span> win = <span class="keyword">new</span> BrowserWindow();                  <span class="comment">// 其他的跟主进程的操作都一样</span></div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <p>remote 模块除了可以访问主进程的内置模块，自身还有一些方法。</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line">remote.require(<span class="built_in">module</span>)          <span class="comment">// 返回在主进程中执行 require(module) 所返回的对象</span></div><div class="line">remote.getCurrentWindow()       <span class="comment">// 返回该网页所属的 BrowserWindow 对象</span></div><div class="line">remote.getCurrentWebContents()  <span class="comment">// 返回该网页的 WebContents 对象</span></div><div class="line">remote.getGlobal(name)          <span class="comment">// 返回在主进程中名为 name 的全局变量(即 global[name])</span></div><div class="line">remote.process                  <span class="comment">// 返回主进程中的 process 对象，等同于 remote.getGlobal('process') 但是有缓存</span></div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <h2 id="shell-模块">
                                  <a href="#shell-模块" class="headerlink" title="shell 模块"></a>shell 模块</h2>
                                <p>使用系统默认应用管理文件和 URL，而且在主进程和渲染进程中都可以用到该模块。在菜单中，我想点击子菜单打开一个网站，那么就可以用到 shell.openExternal() 方法，则会在默认浏览器中打开 URL</p>
                                <figure class="highlight js">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div><div class="line">2</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line"><span class="keyword">const</span> {shell} = <span class="built_in">require</span>(<span class="string">'electron'</span>);</div><div class="line">shell.openExternal(<span class="string">'https://github.com/lin-xin/calculator'</span>);</div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <h2 id="打包应用">
                                  <a href="#打包应用" class="headerlink" title="打包应用"></a>打包应用</h2>
                                <p>其实将程序打包成桌面应用才是比较麻烦的事。我这里尝试了 electron-packager 和 electron-builder。</p>
                                <h3 id="electron-packager">
                                  <a href="#electron-packager" class="headerlink" title="electron-packager"></a>electron-packager</h3>
                                <p>electron-packager 可以将项目打包成各平台可直接运行的程序，而不是安装包。</p>
                                <p>先使用 npm 安装： npm install electron-packager -S</p>
                                <p>运行打包命令：</p>
                                <figure class="highlight plain">
                                  <table>
                                    <tbody>
                                      <tr>
                                        <td class="gutter">
                                          <pre><div class="line">1</div></pre>
                                        </td>
                                        <td class="code">
                                          <pre><div class="line">electron-packager ./ 计算器 --platform=win32 --overwrite --icon=./icon.ico</div></pre>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </figure>
                                <p>打包会把项目文件包括 node_modules 也一起打包进去，当然可以通过 –ignore=node_modules 来忽略文件，但是如果项目中有用到第三方库，忽略的话则找不到文件报错了。</p>
                                <p>正确的做法就是严格区分 dependencies 和 devDependencies，打包的时候只会把 dependencies 的库打包，而使用 cnpm 安装的会有一大堆 .0.xx@xxx 的文件，也会被打包，所以最好不要用 cnpm</p>
                                <h3 id="electron-builder">
                                  <a href="#electron-builder" class="headerlink" title="electron-builder"></a>electron-builder</h3>
                                <p>electron-builder 是基于 electron-packager 打包出来的程序再做安装处理，将项目打包成安装文件。</p>
                                <p>安装：npm install electron-builder -S</p>
                                <p>打包：electron-builder –win</p>
                                <p>打包过程中，第一次下载 electron 可能会出现连接超时，可以使用 yarn 试试。还有 winCodeSign 和 nsis-resources 也可能会失败，可以参考
                                  <a href="https://github.com/electron-userland/electron-builder/issues/1859" target="_blank" rel="external">electron-builder/issues</a>
                                  解决。</p>
                                <h2 id="总结">
                                  <a href="#总结" class="headerlink" title="总结"></a>总结</h2>
                                <p>Electron 用起来还是相对容易的，可以创建个简单的桌面应用，只是打包的过程比较容易遇到问题，网上好像也有一键打包的工具，没尝试过。以上也都是基于 windows 7 的实践，毕竟没有 Mac 搞不了。</p>
