<%-- 
    Document   : index
    Created on : 09/04/2016, 19:00:03
    Author     : flaviosampaioreisdelima
--%>
<%@page import="java.util.Collection"%>
<%@page import="br.com.minaciolog.gerenciador.beans.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<main>
    <div class="section" id="index-banner">
        <div class="container">
            <div class="row">
                <div class="col s12 m9">
                    <h1 class="header center-on-small-only">Clientes</h1>
                    <h4 class="light deep-orange-text text-lighten-4 center-on-small-only">Gerenciador de Clientes</h4>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <!-- ARMAZENAR TODAS AS DIVS DE CONTEÚDO DO SITE -->
        <div class="col s9 m8 l10">
            <!-- CONTEÚDO DE CADA PÁGINA -->
            <div class="col s12 m8 l12">
                <div id="introduction" class="section scrollspy">
                    <div class="divider"></div>
                    <h4 class="header">Clientes <i class="material-icons">face</i></h4>
                    <div class="section">
                        <table class="responsive-table">
                            <thead>
                                <tr>
                                    <th data-field="codigo">Código</th>
                                    <th data-field="descricao">Nome do Cliente</th>
                                    <th data-field="tipo-cliente">Tipo de Cliente</th>
                                    <th data-field="tipo-faturamento">Tipo de Faturamento</th>
                                    <th data-field="acao">Ação</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty listaCliente}">
                                    <c:forEach var="cliente" items="${listaCliente}">
                                        <tr>
                                            <th scope="row">${cliente.codigo}</th>
                                            <td id="descricao-${cliente.codigo}"><a href="Executa?logicaDeNegocio=AgendaServlet&tarefa=consultar&codigo=${cliente.codigo}" class="waves-effect waves-light">${cliente.nome}</a></td>
                                            <td id="tipo-cliente${cliente.codigo}">${cliente.descricaoTipoCliente}</td>
                                            <td id="tipo-faturamento-${cliente.codigo}">${cliente.descricaoFaturamento}</td>
                                            <td>
                                                <!-- Dropdown Trigger -->
                                                <a class='dropdown-button btn-floating red darken-2' href='#' data-constrainwidth="false" data-activates='dropdown${cliente.codigo}'><i class="material-icons">more_horiz</i></a>

                                                <!-- Dropdown Structure -->
                                                <ul id='dropdown${cliente.codigo}' class='dropdown-content'>
                                                    <li class="divider"></li>
                                                    <li><a class="botao-alterar-cliente grey-text text-darken-4" id="${cliente.codigo}"><i class="material-icons yellow-text text-darken-4">edit</i>Alterar</a></li>
                                                    <li class="divider"></li>
                                                    <li><a class="botao-excluir grey-text text-darken-4" id="${cliente.codigo}"><i class="material-icons deep-orange-text">delete</i>Excluir</a></li>
                                                </ul>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                        <br><br><br>
                    </div>
                </div>
            </div>

            <!-- ESTRUTURA DA MODAL ALTERAR -->
            <div id="modal-alterar" class="modal modal-fixed-footer">
                <form method="POST" action="Executa">
                    <div class="modal-content">
                        <h4>Alterar Cliente</h4>
                        <p>Altere o Cliente selecionado:</p>

                        <!--Nome das Classes que deverão ser informadas na requisição-->
                        <input type="hidden" name="logicaDeNegocio" value="ClienteServlet">
                        <input type="hidden" name="tarefa" value="alterar">
                        <input type="hidden" name="codigo" id="codigo-alterar">

                        <div class="input-field">
                            <i class="material-icons prefix">description</i>
                            <input id="descricao-alterar" type="text" name="descricao" />
                        </div>

                        <div class="input-field">
                            <select name="tipoCliente" id="select-tipo-cliente">
                                <option value="" disabled selected>Escolha o Tipo de Cliente</option>
                                <c:forEach var="tipoCliente" items="${listaTipoCliente}">
                                    <option value="${tipoCliente.codigo}" class="form-control" >${tipoCliente.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <select name="tipoFaturamento">
                                <option value="" disabled selected>Escolha o Tipo de Faturamento</option>
                                <c:forEach var="tipoFaturamento" items="${listaTipoFaturamento}">
                                    <option value="${tipoFaturamento.codigo}" >${tipoFaturamento.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="modal-action waves-effect waves-green btn btn-default deep-orange" value="Alterar">Alterar</button>
                        <a href="#!" class="modal-close waves-effect waves-red btn-flat">Cancelar</a>
                    </div>
                </form>
            </div>
            <!-- ESTRUTURA DA MODAL EXCLUIR -->
            <div id="modal-excluir" class="modal modal-fixed-footer">
                <form method="POST" action="Executa">
                    <div class="modal-content">
                        <h4>Excluir Cliente</h4>
                        <p>Confirme a exclusão do Cliente selecionado:</p>

                        <!--Nome das Classes que deverão ser informadas na requisição-->
                        <input type="hidden" name="logicaDeNegocio" value="ClienteServlet">
                        <input type="hidden" name="tarefa" value="remover">
                        <input type="hidden" name="codigo" id="codigo-excluir">

                        <div class="input-field">
                            <i class="material-icons prefix">description</i>
                            <input disabled class="grey-text text-darken-4" id="descricao-excluir" type="text" name="descricao" value="" />
                        </div>



                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="modal-action waves-effect waves-green btn btn-default deep-orange" value="Alterar">Confirmar Exclusão</button>
                        <a href="#!" class="modal-close waves-effect waves-red btn-flat">Cancelar</a>
                    </div>
                </form>
            </div>

            <!-- ABRE MODAL INCLUIR -->
            <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
                <a class="modal-trigger btn-floating btn-large red" href="#modal-incluir">
                    <i class="large material-icons">add</i>
                </a>
            </div>
            
            <!-- ESTRUTURA DA MODAL INCLUIR -->
            <div id="modal-incluir" class="modal modal-fixed-footer">
                <form method="POST" action="Executa">
                    <div class="modal-content">
                        <h4>Incluir Cliente</h4>
                        <p>Insira os dados do novo Cliente:</p>

                        <!--Nome das Classes que deverão ser informadas na requisição-->
                        <input type="hidden" name="logicaDeNegocio" value="ClienteServlet">
                        <input type="hidden" name="tarefa" value="incluir">

                        <div class="input-field">
                            <i class="material-icons prefix">account_circle</i>
                            <label for="descricao-incluir">Nome</label>
                            <input id="descricao-incluir" type="text" class="validate" name="descricao" value="" />
                        </div>

                        <div class="input-field">
                            <select name="tipoCliente">
                                <option value="" disabled selected>Escolha o Tipo de Cliente</option>
                                <c:forEach var="tipoCliente" items="${listaTipoCliente}">
                                    <option value="${tipoCliente.codigo}" class="form-control" >${tipoCliente.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <select name="tipoFaturamento">
                                <option value="" disabled selected>Escolha o Tipo de Faturamento</option>
                                <c:forEach var="tipoFaturamento" items="${listaTipoFaturamento}">
                                    <option value="${tipoFaturamento.codigo}" >${tipoFaturamento.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="modal-action waves-effect waves-green btn btn-default deep-orange" value="Cadastrar">Cadastrar</button>
                        <a href="#!" class="modal-close waves-effect waves-red btn-flat">Cancelar</a>
                    </div>
                </form>
            </div>		
        </div>

    </div>
</main>
<%@ include file="footer.jsp" %>
