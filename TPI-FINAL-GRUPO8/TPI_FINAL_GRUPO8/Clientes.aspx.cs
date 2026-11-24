using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;

namespace TPI_FINAL_GRUPO8
{     
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClienteNegocio negocio = new ClienteNegocio();
                Session.Add("listaCliente", negocio.listar());
                gvClientes.DataSource =Session["listaCliente"];
                gvClientes.DataBind();
            }
        }

        protected void gvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = gvClientes.SelectedDataKey.Value.ToString();
            Response.Redirect("FormCliente.aspx?id="+id);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormCliente.aspx", false);
        }

        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            AplicarFiltros();
        }

        protected void ddlEstadoCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            AplicarFiltros();
        }
        private void AplicarFiltros()
        {
            List<Cliente> cliente = Session["listaCliente"] as List<Cliente>;
            if (cliente == null)
                return;

            string filtro = txtFiltro.Text.Trim().ToUpper();
            string estado = ddlEstadoCliente.SelectedValue;
            bool filtrarEstado = estado != "Todos";

            if(filtro.Length > 0)
            {
                cliente = cliente.FindAll(clientes => clientes.Dni.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0
                || clientes.Nombre.IndexOf(filtro,StringComparison.OrdinalIgnoreCase) >=0);
            }
            if (filtrarEstado)
            {
                bool mostrarActivos = estado == "Activos";
                cliente = cliente.FindAll(clientes => clientes.Activo == mostrarActivos);
            }

            gvClientes.DataSource = cliente;
            gvClientes.DataBind();
        }
    }
}