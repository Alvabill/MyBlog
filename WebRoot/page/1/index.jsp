<%@ page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.vae.domain.*" %>
<%@ page import="com.vae.dao.*" %>

<%
  int artID = 1;

  ArticleDao atcDao = DaoFactory.getArticleDaoInstance();
  Article article = atcDao.findById(artID);
  String title = article.getTitle();
  int reads = article.getReads()+1;
  String cre_time = article.getCre_time().toString();
  String cate_name = article.getCate_name();
  String content = article.getContent();

  article.setReads(reads);
  atcDao.updateReads(article);

%>
<%
   CommentDao cmDao = DaoFactory.getCommentDaoInstance();
   List<Comment> cmList = cmDao.findByArtId(artID);
   int commentNumber = 0;
   if(!cmList.isEmpty()){
	   for(Comment comment:cmList){
		   commentNumber++;
	   }
   }
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>blog排版模板</title>

  <link rel="stylesheet" href="../../asset/css/font-awesome.min.css">
  <link rel="stylesheet" href="../../asset/css/style.css">
  <script src="../../asset/js/main.js"></script>
  <script type="text/javascript">
    function EnterPress(e){
      var e = e || window.event;
      if(e.keyCode == 13){
        var XMLHttpReq;
        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if(window.XMLHttpRequest) { //Mozilla 浏览器
                XMLHttpReq = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) { // IE浏览器
                try {
                    XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e) {
                    try {
                        XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (e) {}
                }
            }
        }
        //发送请求函数
        function sendRequest() {
            createXMLHttpRequest();
            var content = document.getElementById("comment-content").value;
            var url = "../ajax.jsp?artID="+'<%=artID%>'+"&uid="+1+"&content="+content;
            XMLHttpReq.open("GET", url, true);
            XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
            XMLHttpReq.send(null);  // 发送请求
        }
        // 处理返回信息函数
        function processResponse() {
            if (XMLHttpReq.readyState == 4) { // 判断对象状态
                if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
                    Display();
                    setTimeout("sendRequest()", 1000);
                } else { //页面不正常
                    window.alert("您所请求的页面有异常。");
                }
            }
        }
        function Display() {
          <%
            StringBuilder comment_item = new StringBuilder("");
            cmList = cmDao.findByArtId(artID);
            commentNumber = 0;
            if(!cmList.isEmpty()){
         	   for(Comment comment:cmList){
         		   commentNumber++;
               	   int uid = comment.getUid();
               	   MemberDao mbDao = DaoFactory.getMemberDaoInstance();
               	   Member mb = mbDao.findById(uid);
	               comment_item.append(
	                 String.format(" <div class='comment-data-item'><img class='comment-data-item-img' src='%s'><span class='comment-data-item-name'>%s</span><span class='comment-data-item-time'>%s</span><p class='comment-data-item-content'>%s</p></div>",
	                  mb.getUrl(),
	                  mb.getNickname(),
	                  comment.getCommentdate().toString(),
	                  comment.getComment_content()
	               ));
         	   }
            }
          %>
            // var name = XMLHttpReq.responseXML.getElementsByTagName("name")[0].firstChild.nodeValue;
            // // var count = XMLHttpReq.responseXML.getElementsByTagName("count")[0].firstChild.nodeValue;
            // document.getElementById("comment-items").innerHTML = '<%=comment_item %>';
        }

        sendRequest();

      }
    }

  </script>
</head>
<body>
  <%-- header --%>
    <header id="header">
      <nav id="nav" class="wrapper">
        <div class="nav-logo">
          <a href="#">
            <span>MyBlog</span>
          </a>
        </div>
        <div class="navbar">
          <ul>
            <li>
              <a href="#">
                <i class="fa fa-home fa-fw"></i>&nbsp; 主页</a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-home fa-fw"></i>&nbsp; 分类</a>
            </li>
            <li>
              <a href="#">
                <i class="fa fa-home fa-fw"></i>&nbsp; 关于</a>
            </li>
          </ul>
        </div>
      </nav>
    </header>

  <%-- section --%>
  <section class="wrapper">
    <p class="blog-title"><%=title %></p>
    <div class="blog-meta">
      <span class="post-time"><%=cre_time %></span>
      <span class="post-category"><%=cate_name %></span>
      <span class="post-reads"><%=reads %></span>
    </div>
    <div class="blog-body">
      <p>
        Notification API 是 HTML5 新增的桌面通知 API，用于向用户显示通知信息。该通知是脱离浏览器的，即使用户没有停留在当前标签页，甚至最小化了浏览器，该通知信息也一样会置顶显示出来。</p><a id="more"></a>
      <h2 id="用户权限"><a href="#用户权限" class="headerlink" title="用户权限"></a>用户权限</h2>
      <p>想要向用户显示通知消息，需要获取用户权限，而相同的域名只需要获取一次权限。只有用户允许的权限下，Notification 才能起到作用，避免某些网站的广告滥用 Notification 或其它给用户造成影响。那么如何知道用户到底是允不允许的？</p>
      <p>Notification.permission 该属性用于表明当前通知显示的授权状态，可能的值包括：</p>
      <ul>
        <li>default ：不知道用户的选择，默认。</li>
        <li>granted ：用户允许。</li>
        <li>denied ：用户拒绝。</li>
      </ul>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div></pre></td>
              <td class="code"><pre><div class="line"><span class="keyword">if</span>(Notification.permission === <span class="string">'granted'</span>){</div><div class="line">    <span class="built_in">console</span>.log(<span class="string">'用户允许通知'</span>);</div><div class="line">}<span class="keyword">else</span> <span class="keyword">if</span>(Notification.permission === <span class="string">'denied'</span>){</div><div class="line">    <span class="built_in">console</span>.log(<span class="string">'用户拒绝通知'</span>);</div><div class="line">}<span class="keyword">else</span>{</div><div class="line">    <span class="built_in">console</span>.log(<span class="string">'用户还没选择，去向用户申请权限吧'</span>);</div><div class="line">}</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <h2 id="请求权限"><a href="#请求权限" class="headerlink" title="请求权限"></a>请求权限</h2>
      <p>当用户还没选择的时候，我们需要向用户去请求权限。Notification 对象提供了 requestPermission() 方法请求用户当前来源的权限以显示通知。</p>
      <p>以前基于回调的语法已经弃用（当然在现在的浏览器中还是能用的），最新的规范已将此方法更新为基于 promise 的语法：</p>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div></pre></td>
              <td class="code"><pre><div class="line">Notification.requestPermission().then(<span class="function"><span class="keyword">function</span>(<span class="params">permission</span>) </span>{</div><div class="line">    <span class="keyword">if</span>(permission === <span class="string">'granted'</span>){</div><div class="line">        <span class="built_in">console</span>.log(<span class="string">'用户允许通知'</span>);</div><div class="line">    }<span class="keyword">else</span> <span class="keyword">if</span>(permission === <span class="string">'denied'</span>){</div><div class="line">        <span class="built_in">console</span>.log(<span class="string">'用户拒绝通知'</span>);</div><div class="line">    }</div><div class="line">});</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <h2 id="推送通知"><a href="#推送通知" class="headerlink" title="推送通知"></a>推送通知</h2>
      <p>获取用户授权之后，就可以推送通知了。</p>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div></pre></td>
              <td class="code"><pre><div class="line"><span class="keyword">var</span> notification = <span class="keyword">new</span> Notification(title, options)</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <p>参数如下：</p>
      <ul>
        <li>title：通知的标题</li>
        <li>options：通知的设置选项（可选）。
          <ul>
            <li>body：通知的内容。</li>
            <li>tag：代表通知的一个识别标签，相同tag时只会打开同一个通知窗口。</li>
            <li>icon：要在通知中显示的图标的URL。</li>
            <li>image：要在通知中显示的图像的URL。</li>
            <li>data：想要和通知关联的任务类型的数据。</li>
            <li>requireInteraction：通知保持有效不自动关闭，默认为false。</li>
          </ul>
        </li>
      </ul>
      <p>还有一些其他的参数，因为用不了或者没什么用这里就没必要说了。</p>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div></pre></td>
              <td class="code"><pre><div class="line"><span class="keyword">var</span> n = <span class="keyword">new</span> Notification(<span class="string">'状态更新提醒'</span>,{</div><div class="line">    <span class="attr">body</span>: <span class="string">'你的朋友圈有3条新状态，快去查看吧'</span>,</div><div class="line">    <span class="attr">tag</span>: <span class="string">'linxin'</span>,</div><div class="line">    <span class="attr">icon</span>: <span class="string">'http://blog.gdfengshuo.com/images/avatar.jpg'</span>,</div><div class="line">    <span class="attr">requireInteraction</span>: <span class="literal">true</span></div><div class="line">})</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <p>通知消息的效果图如下：</p>
      <p><img src="http://blog.gdfengshuo.com/images/post/notification.png" alt="image"></p>
      <h2 id="关闭通知"><a href="#关闭通知" class="headerlink" title="关闭通知"></a>关闭通知</h2>
      <p>从上面的参数可以看出，并没有一个参数用来配置显示时长的。我想要它 3s 后自动关闭的话，这时可以调用 close() 方法来关闭通知。</p>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div></pre></td>
              <td class="code"><pre><div class="line"><span class="keyword">var</span> n = <span class="keyword">new</span> Notification(<span class="string">'状态更新提醒'</span>,{</div><div class="line">    <span class="attr">body</span>: <span class="string">'你的朋友圈有3条新状态，快去查看吧'</span></div><div class="line">})</div><div class="line"></div><div class="line">setTimeout(<span class="function"><span class="keyword">function</span>(<span class="params"></span>) </span>{</div><div class="line">    n.close();</div><div class="line">}, <span class="number">3000</span>);</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <h2 id="事件"><a href="#事件" class="headerlink" title="事件"></a>事件</h2>
      <p>Notification 接口的 onclick属性指定一个事件侦听器来接收 click 事件。当点击通知窗口时会触发相应事件，比如打开一个网址，引导用户回到自己的网站去。</p>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div><div class="line">8</div><div class="line">9</div><div class="line">10</div></pre></td>
              <td class="code"><pre><div class="line"><span class="keyword">var</span> n = <span class="keyword">new</span> Notification(<span class="string">'状态更新提醒'</span>,{</div><div class="line">    <span class="attr">body</span>: <span class="string">'你的朋友圈有3条新状态，快去查看吧'</span>,</div><div class="line">    <span class="attr">data</span>: {</div><div class="line">        <span class="attr">url</span>: <span class="string">'http://blog.gdfengshuo.com'</span></div><div class="line">    }</div><div class="line">})</div><div class="line">n.onclick = <span class="function"><span class="keyword">function</span>(<span class="params"></span>)</span>{</div><div class="line">    <span class="built_in">window</span>.open(n.data.url, <span class="string">'_blank'</span>);      <span class="comment">// 打开网址</span></div><div class="line">    n.close();                              <span class="comment">// 并且关闭通知</span></div><div class="line">}</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <h2 id="应用场景"><a href="#应用场景" class="headerlink" title="应用场景"></a>应用场景</h2>
      <p>前面说那么多，其实就是为了用。那么到底哪些地方可以用到呢？</p>
      <p>现在网站的消息提醒，大多数都是在消息中心显示个消息数量，然后发邮件告诉用户，这流程完全没有错。不过像我这种用户，觉得别人点个赞，收藏一下都要发个邮件提醒我，老是要去删邮件（强迫症），我是觉得挺烦的甚至关闭了邮件提醒。</p>
      <p>当然这里并不是说要用 Notification，毕竟它和邮件的功能完全不一样。</p>
      <p>我觉得比较适合的是新闻网站。用户浏览新闻时，可以推送给用户实时新闻。以腾讯体育为例，它就使用了 Notification API。在页面中引入了一个 notification2017_v0118.js，有兴趣可以看看别人是怎么成熟的使用的。</p>
      <p>一进入页面，就获取授权，同时自己页面有个浮动框提示你允许授权。如果允许之后，就开始给你推送通知了。不过它在关闭标签卡的时候，通知也会被关闭，那是因为监听了页面 beforeunload 事件。</p>
      <figure class="highlight js">
        <table>
          <tbody>
            <tr>
              <td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div><div class="line">5</div><div class="line">6</div><div class="line">7</div><div class="line">8</div></pre></td>
              <td class="code"><pre><div class="line"><span class="function"><span class="keyword">function</span> <span class="title">addOnBeforeUnload</span>(<span class="params">e</span>) </span>{</div><div class="line">	FERD_NavNotice.notification.close();</div><div class="line">}</div><div class="line"><span class="keyword">if</span>(<span class="built_in">window</span>.attachEvent){</div><div class="line">	<span class="built_in">window</span>.attachEvent(<span class="string">'onbeforeunload'</span>, addOnBeforeUnload);</div><div class="line">} <span class="keyword">else</span> {</div><div class="line">	<span class="built_in">window</span>.addEventListener(<span class="string">'beforeunload'</span>, addOnBeforeUnload, <span class="literal">false</span>);</div><div class="line">}</div></pre></td>
            </tr>
          </tbody>
        </table>
      </figure>
      <h2 id="兼容"><a href="#兼容" class="headerlink" title="兼容"></a>兼容</h2>
      <p>说到兼容，自然是倒下一大片，而且各浏览器的表现也会有点差异。移动端的几乎全倒，PC端的还好大多都能支持，除了IE。所以使用前，需要先检查一下浏览器是否支持 Notification。</p>
    </div>
  </section>
  <hr style="width:750px;color:gray">

  <div class="comments">
    <span class="comment-number">
      <%=commentNumber %>条评论
    </span>
    <span class="comment-login">登录</span>
    <div class="comment-textarea">
     <input id="comment-content" type="text" name="" value="我来说两句..." onkeypress="EnterPress(event)">
    </div>
  </div>
  <div class="comment-data">
      <p class="comment-data-news">最新</p>
      <%-- <div id="comment-items"></div> --%>
      <%=comment_item %>
      <%-- <div class="comment-data-item">
        <img class="comment-data-item-img"src="../../asset/img/wwb.jpg">
        <span class="comment-data-item-name">wwb</span>
        <span class="comment-data-item-time">2017-12-10 22:22:22</span>
        <p class="comment-data-item-content">hhhhhhhhhhhhhhhh</p>
      </div> --%>
  </div>

  <%-- footer --%>
  <footer id="footer">
    <div class="wrapper">
      <p>Copyright © 2017 15352344. All Rights Reserved.
        <a href="index.jsp" title="myBlog" target="_blank">MyBlog</a>
      </p>
    </div>
  </footer>
</body>
</html>
