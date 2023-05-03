<%@ page language="java" pageEncoding="UTF-8"
	import="javabean.*,java.util.*"%>
<%
	User user = (User) session.getAttribute("current_user");
	String user_role;
	if (user.getRole().equals("0")) {
		user_role = "Admin";
	} else
		user_role = "User";

	String id = request.getParameter("id");
	String key = request.getParameter("key");
	ArrayList<Map> list = new Sthouse().queryByStatic(id, key);
	if (id == null)
		id = "";
	if (key == null)
		key = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>仓库管理系统</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<style>
.rounded-input {
	border-radius: 1rem;
}

.navbar-brand {
	font-size: 1.5rem;
	font-family: Roboto;
}

.form-check-input[type="radio"]:checked {
	background-color: #343a40;
	border-color: #343a40;
}

.nav-masthead .nav-link {
	color: rgba(255, 255, 255, .5);
	border-bottom: .25rem solid transparent;
}

.nav-masthead .nav-link:hover, .nav-masthead .nav-link:focus {
	border-bottom-color: rgba(255, 255, 255, .25);
}

.nav-masthead .nav-link+.nav-link {
	margin-left: 1rem;
}

.nav-masthead .active {
	color: #fff;
	border-bottom-color: #fff;
}
</style>

</head>
<body class="d-flex flex-column min-vh-100">
	<header class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="sthouse_list.jsp">Storehouse</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 nav-masthead">
					<li class="nav-item"><a class="nav-link active"
						href="sthouse_list.jsp">仓库管理</a></li>
					<li class="nav-item"><a class="nav-link"
						href="storehouse_list2.jsp">货物管理</a></li>
					<li class="nav-item"><a class="nav-link" href="user_list.jsp">用户管理</a>
					</li>
				</ul>
				<div class="dropdown">
					<button class="btn btn-warning dropdown-toggle" type="button"
						id="dropdownMenuButton" data-bs-toggle="dropdown"
						aria-expanded="false">
						<%=user.getUsername()%>(<%=user_role%>)
					</button>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="dropdownMenuButton">
						<li><a class="dropdown-item" href="user_login.html">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>
	</header>
	<main class="flex-grow-1">
	<div class="container my-3">
		<div class="card border-0">
			<div class="card-body">
				<h1 class="mt-2 mb-2">仓库管理</h1>

				<form class="row g-3 mt-2" action="">
					<div class="col-2 my-2">
						<div class="form-floating">
							<input type="text" class="form-control form-control-lg" id="id"
								name="id" placeholder="Id" value="<%=id%>"> <label
								for="id">编号</label>
						</div>
					</div>
					<div class="col-4 my-2">
						<div class="form-floating">
							<input type="text" class="form-control form-control-lg" id="key"
								name="key" placeholder="关键词" value="<%=key%>"> <label
								for="key">关键词</label>
						</div>
					</div>
					<div class="col-auto my-2 d-flex justify-content-center">
						<div class="align-self-center">
							<button type="submit" class="btn btn-dark me-2"
								style='border-radius: 13px;'>查询</button>
							<button type="button" class="btn btn-danger"
								style="border-radius: 13px;"
								onclick="document.getElementById('id').value=''; document.getElementById('key').value='';">清空</button>
						</div>
					</div>
				</form>

				<table class="table table-hover shadow mt-4">
					<thead class="table-dark">
						<tr>
							<th>仓库编号</th>
							<th>仓库名称</th>
							<th>仓库地址</th>
							<th>货物总数量</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						<%
							for (Map map : list) {
								out.print("<tr>");
								out.print("<td>" + map.get("storehouseid") + "</td>");
								out.print("<td>" + map.get("storehousename") + "</td>");
								out.print("<td>" + map.get("storehouseaddress") + "</td>");
								out.print("<td>" + map.get("total_amount") + "</td>");
								out.print(
										"<td>" + "<a class='btn btn-sm btn-outline-dark' style='border-radius: 15px;' href=sthouse_show.jsp?id="
												+ map.get("storehouseid") + ">编辑</a>&nbsp;&nbsp;"
												+ "<a class='btn btn-sm btn-outline-danger' style='border-radius: 15px;' href=stdel?id="
												+ map.get("storehouseid") + ">删除</a></td>");
								out.print("</tr>");
							}
						%>
					</tbody>
				</table>
			</div>
			<div class="card-footer border-0 bg-body">
				<a class='btn btn-sm  btn-dark' style='border-radius: 15px;'
					href="sthouse_add.html">添加</a>
			</div>
		</div>
	</div>
	</main>
	<div class="container py-3">
		<footer
			class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
			<div class="col-md-4">
				<span class="mb-3 mb-md-0 text-muted"> &copy; 2023 王政豪</span>
			</div>
			<ul class="nav col-md-8 justify-content-end align-items-center">
				<li class="nav-item">
					<h5 class="mb-0">Contact me</h5>
				</li>
				<li class="nav-item"><a href="mailto:wzh791307963@163.com"
					class="nav-link px-2 text-muted">Email</a></li>
				<li class="nav-item"><a href="https://github.com/D1viner"
					class="nav-link px-2 text-muted">Github</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link px-2 text-muted"
					onclick="alert('微信号：wzh791307963')">WeChat</a></li>

				<li class="nav-item">
					<h5 class="mb-0 mx-3">|</h5>
				</li>
				<li class="nav-item">
					<h5 class="mb-0">Copy</h5>
				</li>
				<li class="nav-item"><a href="#"
					class="nav-link px-2 text-muted">Privacy Policy</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link px-2 text-muted">Terms of Service</a></li>
			</ul>
		</footer>
	</div>
	<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://cdn.bootcss.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
</body>
</html>
