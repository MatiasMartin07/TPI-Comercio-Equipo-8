using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Productos : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        ProductoNegocio negocio = new ProductoNegocio();
        //        gvProductos.DataSource = negocio.Listar();
        //        gvProductos.DataBind();
        //    }
        //}
        //protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "SolicitarEliminacion")
        //    {
        //        ViewState["IdProductoEliminar"] = Convert.ToInt32(e.CommandArgument);
        //        pnlConfirmarEliminacion.Visible = true;
        //        ScriptManager.RegisterStartupScript(
        //        this,
        //        GetType(),
        //        "abrirConfirmacion",
        //        "window.addEventListener('load', function () { " +
        //        "var ventana = new bootstrap.Modal(document.getElementById('pnlConfirmarEliminacion')); " +
        //        "ventana.show(); " +
        //        "});",
        //        true);
        //    }
        //}
        //protected void btnCancelarEliminacion_Click(object sender, EventArgs e)
        //{
        //    pnlConfirmarEliminacion.Visible = false;
        //    ViewState.Remove("IdProductoEliminar");
        //}
        //protected void btnConfirmarEliminacion_Click(object sender, EventArgs e)
        //{
        //    if (ViewState["IdProductoEliminar"] == null)
        //    {
        //        return;
        //    }

        //    int idProducto = Convert.ToInt32(ViewState["IdProductoEliminar"]);

        //    ProductoNegocio negocio = new ProductoNegocio();
        //    negocio.Eliminar(idProducto);

        //    ViewState.Remove("IdProductoEliminar");

        //    Response.Redirect("Productos.aspx", false);
        //    Context.ApplicationInstance.CompleteRequest();
        //}
    }
}