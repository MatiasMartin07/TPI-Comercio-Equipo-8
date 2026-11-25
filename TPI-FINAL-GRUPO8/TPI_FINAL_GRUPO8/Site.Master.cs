using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            bool esAdmin = usuario != null && string.Equals(usuario.Rol, "Administrador", StringComparison.OrdinalIgnoreCase);
           
            ulSubProductos.Visible = esAdmin;
            liProveedores.Visible = esAdmin;
            liCompras.Visible = esAdmin;
            liUsuarios.Visible = esAdmin;

            if (!esAdmin)
            {
                aProductos.Attributes["class"] = "nav-link";
            }

            bool estaLogueado = usuario != null;

            idLogin.Visible = !estaLogueado;
            lblUsuarioActual.Visible = estaLogueado;
            lnkCerrarSesion.Visible = estaLogueado;

            if (estaLogueado)
            {
                lblUsuarioActual.Text = usuario.Rol; 
            }
        }

        protected void lnkCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Remove("usuarioLogueado");
            Response.Redirect("Login.aspx", false);
        }
    }
}