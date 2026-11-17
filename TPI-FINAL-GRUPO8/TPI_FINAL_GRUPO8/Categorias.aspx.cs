using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace TPI_FINAL_GRUPO8
{
    public partial class Categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
            }
        }

        protected void txtFiltroCategoria_TextChanged(object sender, EventArgs e) {
            CargarCategorias();
        }

        private void CargarCategorias()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            var categorias = negocio.Listar(incluirInactivas: true);
            string filtro = txtFiltroCategoria.Text.Trim();
            bool hayCategorias = categorias.Count > 0;

            if (filtro.Length > 0)
            {
                categorias = categorias.FindAll(categoria =>
                    categoria.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            gvCategorias.EmptyDataText = hayCategorias && filtro.Length > 0 ? "No se encontraron categorías con esa búsqueda." : "No hay categorías para mostrar.";

            gvCategorias.DataSource = categorias;
            gvCategorias.DataBind();
        }

        protected void gvCategorias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "SolicitarEliminacion")
            {
                return;
            }

            int idCategoria = Convert.ToInt32(e.CommandArgument);
            CategoriaNegocio negocio = new CategoriaNegocio();

            ViewState.Remove("IdCategoriaEliminar");

            if (negocio.TieneProductosAsociados(idCategoria))
            {
                lblConfirmacion.Text =
                    "No se puede eliminar esta categoría porque tiene productos asociados. " +
                    "Podés desactivarla desde Editar o cambiar la categoría de esos productos.";
            }
            else
            {
                ViewState["IdCategoriaEliminar"] = idCategoria;
                lblConfirmacion.Text = "¿Querés eliminar definitivamente esta categoría?";
            }

            pnlConfirmarEliminacion.Visible = true;

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "abrirConfirmacion",
                "window.addEventListener('load', function () { " +
                "var ventana = new bootstrap.Modal(document.getElementById('pnlConfirmarEliminacion')); " +
                "ventana.show(); " +
                "});",
                true);
        }

        protected void btnConfirmarEliminacion_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminacion.Visible = false;

            if (ViewState["IdCategoriaEliminar"] == null)
            {
                return;
            }

            int idCategoria = Convert.ToInt32(ViewState["IdCategoriaEliminar"]);
            ViewState.Remove("IdCategoriaEliminar");

            CategoriaNegocio negocio = new CategoriaNegocio();

            if (negocio.TieneProductosAsociados(idCategoria))
            {
                return;
            }

            negocio.Eliminar(idCategoria);

            Response.Redirect("Categorias.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}