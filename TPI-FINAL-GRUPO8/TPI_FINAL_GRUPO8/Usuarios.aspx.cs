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
    }
}