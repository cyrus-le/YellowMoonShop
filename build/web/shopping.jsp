<%-- 
    Document   : shopping.jsp
    Created on : Oct 6, 2020, 10:26:37 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>     
        <title>Shopping Page</title>
        <style>
            body {
                font-family: "Lato", sans-serif;
            }
            div.scrollmenu {
                background-color: #DEB887;
                overflow: auto;
                white-space: nowrap;
            }
            div.scrollmenu a {
                background-color: #DEB887;
                color: black;
                text-align: center;
                border: none;
                outline: none;
                text-decoration: none;
                padding: 14px 0px;
                font-size: 17px;
                display: inline-block;
                width: 24.8%;
            }

            div.scrollmenu a:hover {
                background-color: #a27644;
            }
            div.scrollmenu a.active {
                background-color :#8B4513;
                color: white;
            }

            /* Style the tab content */
            .tabcontent, .all {
                color: #8B4513;
                display: none;
                padding: 40px;
                text-align: center;
                background-color: #FAEBD7
            }
        </style>
    </head>
    <body>


        <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
            <a href="searchProduct" class="navbar-brand">Yellow Moon Shop</a>      

            <form class="form-inline" action="searchProduct">
                <div class="input-group-prepend w-5">
                    <span class="input-group-text" id="basic-addon1">
                        <i class="fas fa-search"></i>
                    </span>
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" type="text" name="txtSearch" placeholder="Cake name" value="${param.txtSearch}"/>
                    <input class="btn btn-outline-success my-2 my-sm-0" type="submit" name="btnAction" value="Search product"/><br>
                    <input type="hidden" name="page" value="0"/>
                    <input type="hidden" name="categoryID" value=""/>
                </div>
            </form>   
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <c:if test="${sessionScope.USER != null}">    
                        <li class="nav-item  my-2  active">
                            <a style="text-decoration: none; right:30px" class="nav-link btn btn-info ml-3" href="track.jsp?txtSearch=${param.txtSearch}&page=${requestScope.CUR_PAGE}&categoryID=${param.categoryID}">
                                <i class="fa fa-receipt"></i> <span class="sr-only">(current)</span>  Check the order
                            </a>
                        </li>
                        <li class="nav-item  my-2">                            
                            <a class="nav-link btn btn-danger  mr-sm-2" style="text-decoration: none; right:30px" href="logout">
                                <i class="fa fa-sign-out-alt"></i>  Logout
                            </a>
                        </li>    
                    </c:if>
                    <c:if test="${sessionScope.USER == null}">  
                        <li class="nav-item  my-2">
                            <a class="nav-link btn btn-primary my-2 my-sm-0" style="text-decoration: none; right:30px" href="login.jsp">
                                <i class="fa fa-sign-in-alt"></i> Sign in
                            </a>
                        </li>
                    </c:if>
                </ul>

            </div>
        </nav>

        <c:if test="${sessionScope.USER!=null}">
            <h1 class="text-right">Have a nice day, ${sessionScope.USER.getFullName()}!</h1>
        </c:if>



        <c:if test="${sessionScope.USER==null}">

            <!--<a href="login.jsp">Login</a>-->
        </c:if>



        <c:set var="all" value="sessionScope.LIST_CAT" />
        <c:if test="${not empty sessionScope.LIST_CAT}">
            <div class="all" id="all">
                <h2>Các loại bánh</h2>
                <p>Hãy chọn loại bánh mà bạn thích</p>
            </div>
            <c:forEach var="dto" items="${sessionScope.LIST_CAT}">
                <div class="tabcontent" id="${dto.getCategoryID()}">
                    <h2>${dto.getCategory()}</h2>
                    <p>${dto.getDescription()}</p>
                </div>
            </c:forEach>
            <c:set var="categoryID" scope="page" value=""/>
            <c:if test="${not empty param.categoryID}">
                <c:set var="categoryID" scope="page" value="${param.categoryID}"/>
            </c:if>
            <script>
                var i, tabcontents;
                tabcontents = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontents.length; i++) {
                    tabcontents[i].style.display = "none";
                }
                document.querySelector("#all").style.display = "block";
                document.getElementById('${pageScope.categoryID}').style.display = "block";
            </script>


            <div class="scrollmenu">
                <a href="searchProduct?txtSearch=${param.txtSearch}&categoryID=&page=0" 
                   <c:if test="${pageScope.categoryID == ''}">
                       class="active"
                   </c:if>
                   >Tất cả loại bánh</a> 
                <c:forEach var="dto" items="${sessionScope.LIST_CAT}">
                    <a href="searchProduct?txtSearch=${param.txtSearch}&categoryID=${dto.getCategoryID()}&page=0"
                       <c:if test="${pageScope.categoryID==dto.getCategoryID()}">
                           class="active"
                       </c:if>
                       >${dto.getCategory()}</a> 
                </c:forEach>
            </div>
        </c:if>



        <c:if test="${not empty requestScope.LIST_PRO}">
            <table class="table table-bordered table-striped" border="1">
                <thead class="thead-light text-center">
                    <tr>
                        <th>#NO</th>
                        <th>Ảnh</th>
                        <th>Tên bánh</th>
                        <th>Mô tả</th>
                        <th>Giá thành</th>
                        <th>Số lượng</th>
                        <th>Loại bánh</th>
                        <th>Ngày tạo</th>
                        <th>Ngày hết hạn</th>
                        <th>Thêm vào giỏ hàng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${requestScope.LIST_PRO}" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>
                                <img src="${dto.getImage()}" width="120" height="120"/>
                            </td>
                            <td>${dto.getName()}</td>
                            <td>${dto.getDescription()}</td>
                            <td>${dto.getPrice()}</td>
                            <td>${dto.getQuantity()}</td>
                            <td>${dto.getCategory().getCategory()}</td>
                            <td>
                                <c:set var="createDate" value="${dto.getCreateDate()}" scope="page"/>
                                <fmt:formatDate pattern = "yyyy-MM-dd" 
                                                value = "${pageScope.createDate}" />
                            </td>
                            <td>
                                <c:set var="expDate" value="${dto.getExpirationDate()}" scope="page"/>
                                <fmt:formatDate pattern = "yyyy-MM-dd" 
                                                value = "${pageScope.expDate}" />
                            </td>
                            <td>
                                <form action="addToCart">
                                    <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                    <input type="hidden" name="page" value="${requestScope.CUR_PAGE}"/>
                                    <input type="hidden" name="categoryID" value="${param.categoryID}"/>
                                    <input type="hidden" name="txtProductID" value="${dto.getProductID()}"/>
                                    <input type="hidden" name="txtName" value="${dto.getName()}"/>
                                    <input type="hidden" name="txtImage" value="${dto.getImage()}"/>
                                    <input type="hidden" name="txtPrice" value="${dto.getPrice()}"/>
                                    <input type="hidden" name="txtCategoryID" value="${dto.getCategory().getCategoryID()}"/>
                                    <input type="hidden" name="txtCategory" value="${dto.getCategory().getCategory()}"/>
                                    <input type="hidden" value="${dto.getQuantity()}" name="txtQuantity" />
                                    <button onclick="
                                        
                                        Swal.fire(
                                                    'Add succesffuly!',
                                                    '${requestScope.ADD_MESS}',
                                                    'success'
                                                    )" class="btn btn-info" type="submit" name="btnAction"><i class="fa fa-plus-circle"></i> Thêm</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <form class="d-flex justify-content-end" action="view.jsp">
            <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
            <input type="hidden" name="page" value="${param.page}"/>
            <input type="hidden" name="categoryID" value="${param.categoryID}"/>
            <button class="btn btn-success" type="submit" name="btnAction" > <i class="fa fa-shopping-cart"></i> View Your Cart</button>
        </form>


        <c:if test="${not empty requestScope.LIST_PRO}">
            <ul class="pagination d-flex justify-content-center">
                <li class="page-item <c:if test="${requestScope.CUR_PAGE eq 0 }">disabled</c:if>">
                    <a  class="page-link" href="searchProduct?page=${requestScope.CUR_PAGE - 1}&txtSearch=${param.txtSearch}&categoryID=${pageScope.categoryID}">Previous</a>
                </li>
                <c:forEach var="i" begin="1" end="${requestScope.PAGE}" step="1">
                    <li class="page-item <c:if test="${requestScope.CUR_PAGE + 1 eq i}">active</c:if>">
                        <a class="page-link" href="searchProduct?page=${i - 1}&txtSearch=${param.txtSearch}&categoryID=${pageScope.categoryID}">${i}</a>
                    </li> 
                </c:forEach>

                <li class="page-item <c:if test="${requestScope.CUR_PAGE eq requestScope.PAGE - 1}">disabled</c:if>">
                    <a class="page-link" href="searchProduct?page=${requestScope.CUR_PAGE + 1}&txtSearch=${param.txtSearch}&categoryID=${pageScope.categoryID}">Next</a>
                </li>
            </ul>
        </c:if>





        <c:if test="${empty requestScope.LIST_PRO}">
            <div class="alert alert-dark my-5 d-flex justify-content-center">
                <p class="text-left font-weight-bold">  <i class="fas fa-search"></i>  NOT FOUND </p>  OOPS We cannot found any products...! 
            </div>
        </c:if>


        <!--        <script>
        <c:if test="${not empty requestScope.ADD_MESS}">
            function callSweetMsg(event) {
                event.preventDefault();
                Swal.fire(
                        'Add succesffuly!',
                        '${requestScope.ADD_MESS}',
                        'success'
                        )
            }
        </c:if>
    </script>-->



        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    </body>
</html>
