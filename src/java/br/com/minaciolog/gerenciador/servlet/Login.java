/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.minaciolog.gerenciador.servlet;

import br.com.minaciolog.gerenciador.beans.Usuario;
import br.com.minaciolog.gerenciador.dao.UsuarioDAO;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author flaviosampaioreisdelima
 */
@WebServlet(urlPatterns = "/login")
public class Login implements LogicaDeNegocio {

    @Override
    public String executa(HttpServletRequest req, HttpServletResponse response) {
        String email = req.getParameter("email");
        String senha = "";

        try {
            senha = new Criptografia().Digest(req.getParameter("senha"));
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
            System.err.println("Erro ao criptografar a senha. Detalhes: " + ex.getMessage());
        }

        Usuario usuario;

        try {
            usuario = new UsuarioDAO().Consultar(email);

            if (usuario == null) {
                HttpSession session = req.getSession();
                session.setAttribute("usuarioInvalido", true);
                return "index.jsp";
            } else if (!senha.equals(usuario.getSenha())) {
                HttpSession session = req.getSession();
                session.setAttribute("senhaInvalida", true);
                return "index.jsp";
            } else {
                HttpSession session = req.getSession();
                session.removeAttribute("senhaInvalida");
                session.removeAttribute("usuarioInvalido");
                session.setAttribute("usuarioLogado", usuario);
                return "index.jsp";
            }

        } catch (SQLException ex) {
            System.err.println("Erro ao consultar usuário no banco de dados. Detalhes: " + ex.getMessage());
            return "erro.html";
        }
    }

    @Override
    public boolean verifica() {
        return false;
    }

}
