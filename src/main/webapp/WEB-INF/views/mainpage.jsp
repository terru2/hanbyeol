<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.hongik.project.vo.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>공영시설 안내 서비스</title>
</head>
<style>
    .wrap {width: 100%; height: 100%; position: absolute; top: 0;left: 0;background-image: url('resources/images/1478077321.jpg'); background-size:100% 100%;}  
    .title {position: absolute; left: 50%; top: 0; margin-left: -400px; width: 800px; height: 100px; background: rgba(255,255,255,0.8); margin-top: 60px; font-size: 70px; text-align: center; border-radius: 20px; border: 1px solid #ccc;}
    .address {position: absolute; bottom:120px; right: 50px; width: 700px; height:100px;}
    form {display: inline;}
    input[type=submit] {
        padding:5px 15px;
        background: #fff;
        border-radius: 5px; 
    }
    #submit {
 font-size: 15px;
 width: 100px;
 height: 45px;
 border: 2px solid white;
 border: none;
 margin: 0;
 padding: 0;
 background: #fff url(image) 0 0 no-repeat; 
 margin-left: 20px;
}

select::-ms-expand { /* for IE 11 */
    display: none;
}
</style>
<body>
    <div class="wrap">
        <div class="title">
           	공영 시설 안내 서비스
        </div>
        <div class="address">
	        <form action="search.do">
	        	<input type="text" name="address">
				<select name="category1">
					<option value="default">====시설물====</option>
					<c:forEach items="${categorylist}" var="vo">
						<option>${vo.category1}</option>
					</c:forEach>
				</select>
				<input type="submit" value="검색">
			</form>
        </div>
    </div>
</body>
</html>