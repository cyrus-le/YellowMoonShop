<%-- Document : order Created on : Oct 18, 2020, 11:23:30 AM Author : Cyrus --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/> 
        <title>Order Page</title>
    </head>

    <body class="bg-light">                
        <div class="container bg-white">
            <a class="btn btn-outline-secondary" href=view.jsp?txtSearch=${param.search}&page=${param.page}&categoryID=${param.categoryID}"><i class="fa fa-backspace"></i> Back</a>
            <h1 class="text-center">Thông tin người nhận:</h1>
            <form method="POST" action="confirmOrder">
                <c:set var="user" value="${sessionScope.USER}" />

                <div class="form-group">
                    <label>ĐTDĐ: </label>

                    <input class="form-control"  type="text" name="txtPhone" value="${requestScope.PHONE}" <c:if
                               test="${not empty user}">readonly</c:if>/>
                    <font color="red">${requestScope.ERROR.phoneError}</font>
                </div>
                <div class="form-group">

                    <label>Địa chỉ: </label>

                    <input class="form-control" type="text" name="txtAddress" value="${requestScope.ADDRESS}" <c:if
                               test="${not empty user}">readonly</c:if>/>
                    <font color="red">${requestScope.ERROR.addressError}</font> 
                </div>
                <div class="form-group">
                    <label>Tên: </label>
                    <input class="form-control"  type="text" name="txtName" value="${sessionScope.USER.getFullName()}" <c:if
                               test="${not empty user}">readonly</c:if>/>
                    <font color="red">${requestScope.ERROR.nameError}</font> 
                </div>
                <div class="form-group">

                    <label>Phương thức thanh toán: </label>                 
                    <select class="form-control" name="cbPayment">
                        <c:forEach var="dto" items="${requestScope.PAYMENTS}">
                            <option value="${dto.getPaymentID()}">${dto.getPaymentName()}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group ">
                    <c:set var="total" value="${requestScope.TOTAL}" />       
                    <input type="hidden" name="txtTotal" value="${total}" />
                    <input type="hidden" name="txtSearch" value="${param.txtSearch}" />
                    <input type="hidden" name="page" value="${param.page}" />
                    <input type="hidden" name="categoryID" value="${param.categoryID}" />
                    <h3>Total Price: ${total}</h3>
                    <input class="btn btn-warning form-control" type="submit" name="btnAction" value="Confirm" />
                </div>
            </form>
        </div>

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