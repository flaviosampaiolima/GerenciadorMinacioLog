/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.minaciolog.gerenciador.servlet;

import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import br.com.minaciolog.gerenciador.beans.Cliente;
import br.com.minaciolog.gerenciador.dao.ClienteDAO;
import java.util.ArrayList;

/**
 *
 * @author gabri
 */
public class ClienteServlet implements Tarefa {

    //Declarações
    private Cliente cliente = null;
    private String acao;

    @Override
    public String executa(HttpServletRequest req, HttpServletResponse resp) {

        acao = req.getParameter(acao);
        switch (acao) {
            case "incluir":
                try {

                    //instancia uma nova cliente
                    cliente = new Cliente();

                    //Atribui as informações da cliente no objeto
                    cliente.setNome(req.getParameter("nome"));
                    cliente.setCodigoFaturamento(Integer.parseInt(req.getParameter("codigoFaturamento")));
                    cliente.setCodigoTipoCliente(Integer.parseInt(req.getParameter("tipoCliente")));

                    //Grava um nova cliente no banco de dados
                    new ClienteDAO().Incluir(cliente);

                    //Atribui a ultima cliente como Atributo a ser enviado na próxima Requisição 
                    req.setAttribute("incluidoCliente", cliente);

                } catch (SQLException ex) {
                    System.err.println("Erro ao inserir cliente no banco de dados. Detalhes: " + ex.getMessage());
                    return "Erro.html";
                }
                break;

            case "remover":
                try {

                    //instancia uma nova cliente
                    cliente = new Cliente();

                    //Atribui as informações da cliente no objeto
                    cliente.setNome(req.getParameter("descricao"));
                    cliente.setCodigo(Integer.parseInt(req.getParameter("codigo")));
                    cliente.setCodigoFaturamento(Integer.parseInt(req.getParameter("codigoFaturamento")));
                    cliente.setCodigoTipoCliente(Integer.parseInt(req.getParameter("tipoCliente")));

                    //Exclui cliente no banco de dados
                    new ClienteDAO().Excluir(Integer.parseInt(req.getParameter("codigo")));

                    //Atribui a ultima cliente como Atributo a ser enviado na próxima Requisição 
                    req.setAttribute("excluidoCliente", cliente);

                } catch (SQLException ex) {
                    System.err.println("Erro ao remover cliente no banco de dados. Detalhes: " + ex.getMessage());
                    return "Erro.html";
                }
                break;

            case "alterar":
                try {

                    //instancia uma nova cliente
                    cliente = new Cliente();

                    //Atribui as informações da cliente no objeto
                    cliente.setNome(req.getParameter("descricao"));
                    cliente.setCodigo(Integer.parseInt(req.getParameter("codigo")));
                    cliente.setCodigoFaturamento(Integer.parseInt(req.getParameter("codigoFaturamento")));
                    cliente.setCodigoTipoCliente(Integer.parseInt(req.getParameter("tipoCliente")));

                    //altera cliente no banco de dados
                    new ClienteDAO().Alterar(cliente);

                    //Atribui a ultima cliente como Atributo a ser enviado na próxima Requisição 
                    req.setAttribute("alteradoCliente", cliente);

                } catch (SQLException ex) {
                    System.err.println("Erro ao alterar cliente no banco de dados. Detalhes: " + ex.getMessage());
                    return "Erro.html";
                }
                break;

            case "consultar":
                try {

                    //instancia uma nova cliente
                    cliente = new Cliente();

                    //Grava um nova cliente no banco de dados
                    cliente = new ClienteDAO().Consultar(Integer.parseInt(req.getParameter("codigo")));

                    //Atribui a ultima cliente como Atributo a ser enviado na próxima Requisição 
                    req.setAttribute("consultaCliente", cliente);

                } catch (SQLException ex) {
                    System.err.println("Erro ao consultar cliente no banco de dados. Detalhes: " + ex.getMessage());
                    return "Erro.html";
                }
                break;
            case "consultarLista":
                try {

                    ArrayList<Cliente> listaCliente = new ArrayList<>();

                    //Grava um nova cliente no banco de dados
                    listaCliente = new ClienteDAO().Consultar();

                    //Atribui a ultima cliente como Atributo a ser enviado na próxima Requisição 
                    req.setAttribute("consultaListaCliente", listaCliente);

                } catch (SQLException ex) {
                    System.err.println("Erro ao cosultar cliente no banco de dados. Detalhes: " + ex.getMessage());
                    return "Erro.html";
                }
                break;
            default:
                    System.err.println("Erro ao cosultar cliente no banco de dados. Ação inválida!");
                    return "Erro.html";

        }
        return "/WEB-INF/Paginas/Cliente.jsp";
    }

    @Override
    public boolean verifica() {
        return true;
    }

}
