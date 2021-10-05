<%-- Document : index Created on : Oct 6, 2020, 10:49:11 AM Author : Cyrus --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <title>Login Page</title>
    </head>

    <body>
        <div class="container">
            <h1>LOGIN PAGE</h1>
            <img src="./img/1603112561913.jpg" class="rounded-circle mx-auto" alt="alt"/>
            <form action="login" method="POST">
                <div class="form-group">
                    <label for="userID">UserID: </label>
                    <input class="form-control" type="text" name="txtUserID" /></br>
                </div>
                <div class="form-group">
                    <label for="password">Password: </label>
                    <input class="form-control" type="password" name="txtPassword" />
                </div>                           
                <input class="form-control btn btn-outline-success" type="submit" name="btnAction" value="Login"> <br/>
                <input class="form-control btn btn-outline-secondary" type="reset" value="Reset">
            </form>
            <a class="btn btn-outline-danger" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8084/YellowMoonShop/loginGoogle&response_type=code
               &client_id=428092540777-aea38v8jb6fqj6h1nvebcpip3ic5q41u.apps.googleusercontent.com&approval_prompt=force"><i class="fab fa-google-plus-g"></i> Login
                With Google</a>
            <a class="btn btn-outline-info" href="searchProduct"><i class="fa fa-step-backward"></i> Back to shopping</a> <br/>
            ${sessionScope.LOGIN_MESS}<br>
            <br>${sessionScope.MESS}<br>
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