function EnterPress(e){
  var e = e || window.event;
  if(e.keyCode == 13){
    BtnAjax();
  }

}

function BtnAjax(){
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
      var url = "ajax.jsp?artID="+'<%=artID%>'+"&uid="+uid+"&content="+content;
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
       Collections.reverse(cmList);
       for(Comment comment:cmList){
         commentNumber++;
             int userid = comment.getUid();
             MemberDao mbDao = DaoFactory.getMemberDaoInstance();
             Member mb = mbDao.findById(userid);
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
      // var count = XMLHttpReq.responseXML.getElementsByTagName("count")[0].firstChild.nodeValue;
//      document.getElementById("comment-items").innerHTML(<%=comment_item %>);
  }

  sendRequest();
  document.getElementById("comment-content").value = "";
}
