using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace TPI_FINAL_GRUPO8
{
    public partial class Marcas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MarcaNegocio negocio = new MarcaNegocio();
                gvMarcas.DataSource = negocio.Listar();
                gvMarcas.DataBind();
            }
        }

        protected void gvMarcas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SolicitarEliminacion")
            {
                lblError.Text = "";

                int idMarca = Convert.ToInt32(e.CommandArgument);
                MarcaNegocio negocio = new MarcaNegocio();

                ViewState["IdMarcaEliminar"] = idMarca;

                if (negocio.TieneProductosAsociados(idMarca))
                {
                    lblConfirmacion.Text =
                    "No se puede eliminar esta marca porque tiene productos asociados. " +
                    "Podés desactivarla desde Editar, eliminar esos productos o cambiarles la marca.";
                }
                else
                {
                    lblConfirmacion.Text =
                        "¿Querés eliminar definitivamente esta marca?";
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
        }

        protected void btnCancelarEliminacion_Click(object sender, EventArgs e)
        {
            pnlConfirmarEliminacion.Visible = false;
            ViewState.Remove("IdMarcaEliminar");
        }

        protected void btnConfirmarEliminacion_Click(object sender, EventArgs e)
        {
            if (ViewState["IdMarcaEliminar"] == null)
            {
                return;
            }

            int idMarca = Convert.ToInt32(ViewState["IdMarcaEliminar"]);
            MarcaNegocio negocio = new MarcaNegocio();

            if (negocio.TieneProductosAsociados(idMarca))
            {
                pnlConfirmarEliminacion.Visible = false;
                ViewState.Remove("IdMarcaEliminar");
                return;
            }

            negocio.Eliminar(idMarca);

            ViewState.Remove("IdMarcaEliminar");

            Response.Redirect("Marcas.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}