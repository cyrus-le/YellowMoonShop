<%-- Document : track Created on : Oct 20, 2020, 7:17:40 PM Author : Admin --%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>  
        <title>Track Order Page</title>
    </head>

    <body class="bg-light">
        <div class="container">
            <a class="btn btn-outline-secondary"
                href="searchProduct?txtSearch=${param.txtSearch}&page=${param.page}&categoryID=${param.categoryID}"><i class="fa fa-backspace"></i> Back</a>
            <form action="track">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1">
                        OrderID:
                    </span>
                    <input class="form-control" placeholder="Nhập mã order" type="text" name="txtOrderID" />
                    <input class="btn btn-outline-primary" type="submit" name="btnAction" value="Tra cứu">
                    <input type="hidden" name="txtSearch" value="${param.txtSearch}" />
                    <input type="hidden" name="page" value="${param.page}" />
                    <input type="hidden" name="categoryID" value="${param.categoryID}" />
                </div>



            </form>
            <c:if test="${requestScope.ORDER_DETAIL!=null}">
                <c:set var="order" value="${requestScope.ORDER_DETAIL}" />
                <p><span class="font-weight-bold" >Mã Order: </span> ${param.txtOrderID}</p> 
                <p><span class="font-weight-bold" >Mã User: </span>${order.getUserID()}</p> 
                <p><span class="font-weight-bold" >Tên: </span>${order.getName()}</p> 
                <p><span class="font-weight-bold" >Địa chỉ: </span>${order.getAddress()}</p> 
                <p><span class="font-weight-bold" >ĐTDĐ: </span>${order.getPhone()}</p>    
                <p><span class="font-weight-bold" >Ngày đặt: </span>
                    <fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${order.getOrderDate()}" />
                </p>                         
                <p class="font-weight-bold">Danh sách đơn hàng: </p>
                <hr/>
                <c:forEach var="dto" items="${order.getProducts()}">
                    <table class="table table-bordered table-striped" border="1">
                        <thead class="thead-dark text-center">
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Current status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${dto.getProductID()}</td>
                                <td>${dto.getName()}</td>
                                <td>${dto.getPrice()}</td>
                                <td>${dto.getQuantity()}</td>
                                <td>${dto.isStatus()}</td>
                            </tr>
                        </tbody>
                    </table>

                </c:forEach>
                <hr/>
                <p><span class="font-weight-bold" >Phương thức thanh toán: </span>${order.getPaymentName()}</p>    
                <p><span class="font-weight-bold" >Trạng thái thanh toán: </span>${order.isPaymentStatus()}</p>    
            </c:if>
            <c:if test="${requestScope.ORDER_DETAIL==null}">
                <h2>Không tìm thây đơn hàng nào</h2>
            </c:if>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
                integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
                integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
    </body>

</html>