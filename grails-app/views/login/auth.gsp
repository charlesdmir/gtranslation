<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to <g:meta name="appName"/></title>
</head>

<body>
<div class="loginPanel center-block">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4><g:message code="springSecurity.login.header"/></h4>
        </div>

        <div class="panel-body">
            <g:if test='${flash.message}'>
                <div class="alert alert-danger" role="alert">${flash.message}</div>
            </g:if>

            <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                <div class="form-group">
                    <label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
                    <input type='text' class="form-control" name='j_username' id='username'/>
                </div>

                <div class="form-group">
                    <label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
                    <input type='password' class="form-control" name='j_password' id='password'/>
                </div>

                <div class="form-group" id="remember_me_holder">
                    <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me'
                           <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                    <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
                </div>


                <input type='submit' id="submit" class="btn btn-default"
                       value='${message(code: "springSecurity.login.button")}'/>
            </form>
        </div>
    </div>
</div>
<script type='text/javascript'>
    (function () {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
</script>

</body>
</html>