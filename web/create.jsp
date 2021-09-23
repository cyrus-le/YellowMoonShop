<%-- Document : create Created on : Oct 19, 2020, 9:05:55 PM Author : Admin --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=utf-8 />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <link class="jsbin" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/base/jquery-ui.css"
              rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/> 
        <title>Create Moon Cake</title>
    </head>

    <body class="bg-light">
        <c:url var="back" value="search">
            <c:param name="page" value="${param.page}" />
            <c:param name="txtSearch" value="${param.txtSearch}" />
        </c:url>
        <a class="btn btn-outline-secondary"  href="${pageScope.back}"><i class="fa fa-backspace"></i> Back</a>
        <div class="container bg-white">
            <h2 class="text-center">CREATE MOON CAKE</h2>
            <form action="CreateController" method="POST" enctype="multipart/form-data" id="post">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Product ID: </label>
                        <input class="form-control" type="text" name="txtProductID" value="${param.txtProductID}"
                              /> 
                        <font color="red">${requestScope.ERROR.productIDError}</font> 
                    </div>
                    <div class="form-group col-md-6">
                        <label>Product name: </label>
                        <input class="form-control" type="text" name="txtName" value="${param.txtName}"/><br>
                        <font color="red">${requestScope.ERROR.productNameError}</font> <br>
                    </div>
                </div>

                <div class="form-group custom-file">
                    <img id="blah" src="${param.txtImage}" alt="Choose your image:" class="mx-auto d-block" />
                    <input class="form-control" type="file" name="file" onchange="readURL(this);" />
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Description: </label>
                        <input class="form-control" type="text" name="txtDescription" value="${param.txtDescription}" />
                        <font color="red">${requestScope.ERROR.productDescriptionError}</font>
                    </div>
                    <div class="form-group col-md-6">
                        <label>Price: </label>
                        <input class="form-control"  type="text" name="txtPrice" value="${param.txtPrice}"/>
                        <font color="red">${requestScope.ERROR.priceError}</font>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Quantity: </label>
                        <input class="form-control"checked="" type="number" min="1" max="9999" name="txtQuantity"
                               value="${param.txtQuantity}"/><br>
                    </div>
                    <div class="form-group col-md-6">    
                        <label>Category: </label>
                        <select class="custom-select" name="cbCategory">
                            <c:forEach var="dto" items="${sessionScope.LIST_CAT}">
                                <option value="${dto.getCategoryID()}" <c:if
                                            test="${param.txtCategoryID==dto.getCategoryID()}">
                                            selected
                                        </c:if>
                                        >${dto.getCategory()}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>                            
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Created Date (yyyy-MM-dd): </label>
                        <input type="date" name="txtCreateDate"
                               value="${param.txtCreateDate}" />
                    </div>
                    <div class="form-group col-md-6">
                        <label>Expirated Date (yyyy-MM-dd): </label>
                        <input type="date" name="txtExpirationDate"
                               value="${param.txtExpirationDate}" />
                    </div>
                    <font color="red">${requestScope.ERROR.dateError}</font> 
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label> Status: </label>
                        <select class="custom-select" name="cbStatus">
                            <option class="text-success" value="true" <c:if test="${param.txtStatus=='true'}">
                                    selected
                                </c:if>
                                >Active</option>
                            <option class="text-danger" value="false" <c:if test="${param.txtStatus=='false'}">
                                    selected
                                </c:if>
                                >Disactive</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <input class="btn btn-outline-primary form-control" type="submit" name="btnAction" value="Create" />
                        <input type="hidden" name="txtImage" value="${param.txtImage}" />
                        <input type="hidden" name="txtSearch" value="${param.txtSearch}" />
                        <input type="hidden" name="page" value="${param.page}" />
                    </div>
                </div>

            </form>    
        </div>
        <script>
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#blah')
                                .attr('src', e.target.result)
                                .height(400);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
        <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
        <script class="jsbin"
        src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.0/jquery-ui.min.js"></script>
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