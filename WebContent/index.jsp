<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>WebSocket示例</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
      <button onclick="subOpen();">open</button><br/>
      <input type="text" name="msg" id="msg"><br/>
      <button onclick="send();">发送</button>
      <div id="div"></div>
  
  </body>
  
  <script type="text/javascript">
      var ws; // 就是一个通信管道
      var target = "ws://127.0.0.1:8080/websocket/echo";//服务端的url，注意以ws开头
      function subOpen(){
          //三个判断用于获取ws通信管道（浏览器兼容）
          if('WebSocket' in window){
              ws = new WebSocket(target);
          }else if('MozWebSocket' in window){
              ws = new MozMozWebSocket(target);
          }else{
              alert("WebSocket is not supported by this browse");
              return;
          }
          //ws.onopen = function(){}  链接开启会执行方法
          //ws.onclose = function(){}  断开连接会执行方法
          //以上两个实际用处并不多，主要是下面的
          //服务器又信息返回就执行方法
          ws.onmessage=function(event){
              //服务端一返回内容，就把该内容放到div标签当中
              document.getElementById("div").innerHTML = event.data;
              
              //方便在控制台查看返回内容的具体信息
              console.info(event);
          };
      };
      
      function send(){
          //点击发送按钮就把输入框里的内容发送给服务器，并把输入框的内容清空
          var msg = document.getElementById("msg").value;
          ws.send(msg);
          document.getElementById("msg").value = "";
      };
      
  </script>
  
</html>