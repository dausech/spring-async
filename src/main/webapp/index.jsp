<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Spring Async Exemplo</title>

                <!-- Latest compiled and minified CSS -->
                <link rel="stylesheet" href="resources/css/bootstrap.min.css">
                <link rel="stylesheet" href="resources/css/bootstrap-theme.min.css">
                <link rel="stylesheet" href="resources/css/app.css">

                <script src="resources/js/jquery-3.2.1.min.js"></script>
                <script src="resources/js/bootstrap.min.js"></script>
                
                <script>
                        function executarSincronizado(){
                                $("#resultado").html("");
                                $.get('api/pessoa/exec/sincronizada', function(result){ 
                                        $("#resultado").html(result);
                                        
                                }).fail(function(jqXHR, textStatus, errorThrown) {
                                        var html = new DOMParser().parseFromString(jqXHR.responseText, "text/xml");
                                        var body = $(html).find('body').html();
                                        $("#resultado").html( body );
                                });
                        }
                        
                        function executarAssinc(){
                                $("#resultado").html("");
                                $.ajax({
                                        type: "GET",
                                        url: "${pageContext.request.contextPath}/api/pessoa/exec/assinc",
                                        removeBloqueio: true,
                                        success: function (result) {
                                            $("#resultado").html(result);
                                        }
                                });
                        }
                        
                        $(document).ready(function() {                                
                                $(document).ajaxSend(function(event, jqXHR, ajaxOptions) {
                                        if(!ajaxOptions.removeBloqueio) {
                                                $("#bloqueio").addClass("escurecer");
                                        }
                                });
                                $(document).ajaxComplete(function(event, jqXHR, ajaxOptions){
                                        if(!ajaxOptions.removeBloqueio) {
                                                $("#bloqueio").removeClass("escurecer");
                                        }
                                });
                        });
                </script>
        </head>
        <body>
                <div id="bloqueio"></div>
                <div class="panel panel-default">
                        <div class="panel-heading">
                                <h3>Spring Async Exemplo!</h3>
                        </div>
                        <div class="panel-body">                                
                                <div class="row">
                                        <div class="col-lg-12">
                                                <button type="button" class="btn btn-warning" onclick="executarSincronizado()">Importar Sincronizado</button>
                                        </div>
                                        <div class="col-lg-12">&nbsp;</div>
                                        <div class="col-lg-12">
                                                <button id="bntAsync" type="button" class="btn btn-success" onclick="executarAssinc()">Importar com @Async</button>
                                        </div>
                                        <div class="col-lg-12">&nbsp;</div>
                                        <div class="col-lg-12">
                                                <div id="resultado">
                                                </div>
                                        </div>
                                </div>
                        </div>
                </div>
                
        </body>
</html>
