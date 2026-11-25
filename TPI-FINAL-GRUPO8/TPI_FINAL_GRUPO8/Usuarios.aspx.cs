using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;


namespace TPI_FINAL_GRUPO8
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }
            if (usuario.Rol != "Administrador")
            {
                Response.Redirect("Inicio.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
            UsuarioNegocio negocio = new UsuarioNegocio();
            gvUsuario.DataSource = negocio.listar();
            gvUsuario.DataBind();
            }
        }

        protected void gvUsuario_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = gvUsuario.SelectedDataKey.Value.ToString();
            Response.Redirect("FormUsuario.aspx?id=" + id);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormUsuario.aspx", false);
        }

        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            cargarUsuario();
        }

        protected void ddlEstadoCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarUsuario();
        }

        private void cargarUsuario()
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            var usuario = negocio.listar();

            string filtro = txtFiltro.Text.Trim();
            string estado = ddlEstadoUsuario.SelectedValue;
            bool filtrarEstado = estado != "Todos";

            if(filtro.Length > 0)
            {
                usuario = usuario.FindAll(usuarios => usuarios.Rol.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >=0 ||
                usuarios.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >=0 );
            }
            if (filtrarEstado)
            {
                bool mostrarActivos = estado == "Activos";
                usuario = usuario.FindAll(usuarios => usuarios.Activo == mostrarActivos);
            }

            gvUsuario.DataSource = usuario;
            gvUsuario.DataBind();
        }
    }
}