<%-- 
    Document   : view.jsp
    Created on : Oct 14, 2020, 11:12:22 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
    <body class="bg-light">
        <div class="container bg-white">
            <h1>Your Cart</h1>
            <c:if test="${not empty requestScope.UPDATE_CART_MESS}">
                <script>
                    alert("${requestScope.UPDATE_CART_MESS}");
                </script>
            </c:if>
            <c:if test="${requestScope.CONFIRM_MESS!=null}">
                <h1>${requestScope.CONFIRM_MESS}</h1>
                <h1>Your Order ID is: ${requestScope.ORDER_ID}</h1>
            </c:if>
            <c:choose>
                <c:when test="${sessionScope.CART!=null}">
                    <c:if test="${not empty sessionScope.CART.getCart()}">
                        <table class="table table-bordered table-striped" border="1">
                            <thead class="thead-light text-center">
                                <tr>
                                    <th>#NO</th>
                                    <th>Image</th>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>  
                                    <th>Action</th> 
                                </tr>
                            </thead>
                            <tbody class="align-middle">
                                <c:set var="total" value="${0}" scope="page"/>
                            <font color="red" >${requestScope.ERROR}</font>
                            <c:forEach var="dto" items="${sessionScope.CART.getCart().values()}" varStatus="counter">
                                <c:set var="total" value="${pageScope.total+dto.getQuantity()*dto.getPrice()}"/>
                                <form action="updateCartProduct">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>
                                            <img src="${dto.getImage()}" width="120" height="120"/>
                                        </td>
                                        <td>
                                            ${dto.getProductID()}
                                            <input type="hidden" name="txtProductID" value="${dto.getProductID()}"/>
                                        </td>
                                        <td>
                                            ${dto.getName()}
                                        </td>
                                        <td>${dto.getCategory().getCategory()}</td>
                                        <td>${dto.getPrice()}</td>
                                        <td>
                                            <input type="hidden" value="${dto.getQuantityDB()}" name="txtQuantityDB"
                                                   />
                                            <input type="number" min="1" max="1000" name="txtQuantity" value="${dto.getQuantity()}">                                
                                        </td>
                                        <td>${dto.getQuantity()*dto.getPrice()}</td>
                                        <td>
                                            <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                            <input type="hidden" name="page" value="${param.page}"/>
                                            <input type="hidden" name="categoryID" value="${param.categoryID}"/>
                                            <input class="btn btn-primary" type="submit" name="btnAction" value="Update"/>
                                            <c:url var="delete" value="deleteCartProduct">
                                                <c:param name="txtProductID" value="${dto.getProductID()}"></c:param>
                                                <c:param name="txtSearch" value="${param.txtSearch}"></c:param>
                                                <c:param name="page" value="${param.page}"></c:param>
                                                <c:param name="categoryID" value="${param.categoryID}"></c:param>
                                            </c:url>
<!--                                            <a class="btn btn-danger" onclick="return confirm('Are you sure that you want to cancel this product?');" href="${delete}">
                                                <i class="fa fa-trash"></i> Delete
                                            </a>-->
                                            <a class="btn btn-danger" onclick="
                                                    event.preventDefault();
                                                    Swal.fire({
                                                        title: 'Bạn có muốn xóa sản phẩm này ra khỏi giỏ hàng?',
                                                        text: 'Bạn sẽ không khôi phục hàng động này!',
                                                        icon: 'warning',
                                                        showCancelButton: true,
                                                        confirmButtonColor: '#d33',
                                                        cancelButtonColor: '#3085d6 ',
                                                        confirmButtonText: 'Vâng, đồng ý!'
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            event.preventDefault();
                                                            Swal.fire(
                                                                    'Đã xóa!',
                                                                    '${dto.getName()} đã bị xóa.',
                                                                    'success'
                                                                    ).then(result => {
                                                                if (result.isConfirmed) {
                                                                    window.location.href = '${delete}';
                                                                }
                                                            })
                                                        }
                                                    }
                                                    )
                                               ">
                                                <i class="fa fa-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                            </tbody>
                        </table>
                        <h1>Total: ${pageScope.total}</h1>


                    </c:if>
                    <c:if test="${empty sessionScope.CART.getCart()}">
                        <h2>Your cart is empty!</h2>
                    </c:if>
                </c:when>
                <c:when test="${sessionScope.CART==null}">
                    <h2>Your cart is empty!</h2>
                </c:when>
            </c:choose>
            <c:if test="${requestScope.CART_ERROR!=null}">
                <h3>Checkout Fail:</h3>
                <c:forEach var="dto" items="${requestScope.CART_ERROR}">
                    ${dto}
                </c:forEach>
            </c:if>
            <a href="searchProduct?txtSearch=${param.txtSearch}&page=${param.page}&categoryID=${param.categoryID}"><h2>Continue Shopping</h2></a> <br>
            <c:if test="${sessionScope.CART!=null}">
                <c:if test="${not empty sessionScope.CART.getCart()}">
                    <a class="btn btn-warning" href="orderProduct?txtSearch=${param.search}&page=${param.page}&categoryID=${param.categoryID}&total=${pageScope.total}"><h2>Order now</h2></a>
                </c:if>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    </body>
</html>
