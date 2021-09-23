<%-- 
    Document   : admin
    Created on : Oct 19, 2020, 9:52:56 AM
    Author     : Admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <title>Admin Page</title>
    </head>
    <body>
        <h1>Welcome ${sessionScope.USER.getFullName()}!</h1>
        <br><a class="btn btn-outline-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        <a class="btn btn-outline-info" href="create.jsp?txtSearch=${param.txtSearch}&page=${requestScope.CUR_PAGE}"> <i class="fa fa-plus"></i> Create</a>
        <form action="search">
            <div class="input-group-prepend w-5">
                <span class="input-group-text" id="basic-addon1">
                    <i class="fas fa-search"></i>
                </span>
                <input class="form-control" type="text" name="txtSearch" placeholder="Search Cake name" value="${param.txtSearch}"/>
                <input class="btn btn-outline-success" type="submit" name="btnAction" value="Search"/><br>
                <input type="hidden" name="page" value="0"/>
            </div> 
        </form>


        <c:if test="${not empty requestScope.LIST_PRO}">
            <table class="table table-bordered table-hover" border="1">
                <thead class="thead-dark text-center" >
                    <tr>
                         <th>#NO</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Category</th>
                        <th>Create Date</th>
                        <th>Expiration Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${requestScope.LIST_PRO}" varStatus="counter">
                    <form action="update.jsp">
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
                                
                                <c:if test="${dto.isStatus()==true}"><p class="text-success">Active</p></c:if>
                                 <c:if test="${dto.isStatus()==false}"><p class="text-danger">Disactive</p></c:if>
                                
                            </td>
                            <td>
                                <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                <input type="hidden" name="page" value="${requestScope.CUR_PAGE}"/>
                                <input type="hidden" name="txtProductID" value="${dto.getProductID()}"/>
                                <input type="hidden" name="txtName" value="${dto.getName()}"/>
                                <input type="hidden" name="txtImage" value="${dto.getImage()}"/>
                                <input type="hidden" name="txtDescription" value="${dto.getDescription()}"/>
                                <input type="hidden" name="txtPrice" value="${dto.getPrice()}"/>
                                <input type="hidden" name="txtQuantity" value="${dto.getQuantity()}"/>
                                <input type="hidden" name="txtCategoryID" value="${dto.getCategory().getCategoryID()}"/>
                                <input type="hidden" name="txtCreateDate" value="${dto.getFmCreateDate()}"/>
                                <input type="hidden" name="txtExpirationDate" value="${dto.getFmExpirationDate()}"/>
                                <input type="hidden" name="txtStatus" value="${dto.isStatus()}"/>
                                <input class="btn btn-outline-primary" type="submit" name="btnAction" value="Update"/>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
            </tbody>
        </table>
    </c:if>


    <c:if test="${not empty requestScope.LIST_PRO}">
        <ul class="pagination d-flex justify-content-center">
            <li class="page-item <c:if test="${requestScope.CUR_PAGE eq 0 }">disabled</c:if>">
                <a  class="page-link" href="search?page=${requestScope.CUR_PAGE - 1}&txtSearch=${param.txtSearch}">Previous</a>
            </li>
            <c:forEach var="i" begin="1" end="${requestScope.PAGE}" step="1">
                <li class="page-item <c:if test="${requestScope.CUR_PAGE + 1 eq i}">active</c:if>">
                    <a class="page-link" href="search?page=${i - 1}&txtSearch=${param.txtSearch}">${i}</a>
                </li> 
            </c:forEach>

            <li class="page-item <c:if test="${requestScope.CUR_PAGE eq requestScope.PAGE - 1}">disabled</c:if>">
                <a class="page-link" href="search?page=${requestScope.CUR_PAGE + 1}&txtSearch=${param.txtSearch}">Next</a>
            </li>
        </ul>
    </c:if>

    <c:if test="${empty requestScope.LIST_PRO}">
        <div class="alert alert-dark my-5 d-flex justify-content-center">
            <p class="text-left font-weight-bold">  <i class="fas fa-search"></i>  NOT FOUND </p>  OOPS We cannot found any products...! 
        </div>
    </c:if>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
