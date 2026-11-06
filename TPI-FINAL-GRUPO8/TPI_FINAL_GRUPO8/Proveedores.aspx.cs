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
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProveedoresNegocio negocio = new ProveedoresNegocio();
                Session.Add("listaProveedores", negocio.Listar());
                gvProveedores.DataSource = Session["listaProveedores"];
                gvProveedores.DataBind();
            }           
        }
        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            List<Dominio.Proveedores> lista = (List<Dominio.Proveedores>)Session["listaProveedores"];
            List<Dominio.Proveedores> listaFiltrada = lista.FindAll(x => x.RazonSocial.ToUpper().Contains(txtFiltro.Text.ToUpper()) || x.Cuit.ToUpper().Contains(txtFiltro.Text.ToUpper()));
            gvProveedores.DataSource = listaFiltrada;
            gvProveedores.DataBind();
        }
        protected void gvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = gvProveedores.SelectedDataKey.Value.ToString();
            Response.Redirect("FormProveedor.aspx?id=" + id);
        }
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormProveedor.aspx", false);
        }
    }
}