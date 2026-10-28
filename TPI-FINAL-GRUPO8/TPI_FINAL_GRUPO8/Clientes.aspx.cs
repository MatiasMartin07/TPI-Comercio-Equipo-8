using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    ClienteNegocio negocio = new ClienteNegocio();
            //    gvClientes.DataSource = negocio.listar();
            //    gvClientes.DataBind();
            //}
        }

        protected void gvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("FormCliente.aspx", false);
        }
    }
}