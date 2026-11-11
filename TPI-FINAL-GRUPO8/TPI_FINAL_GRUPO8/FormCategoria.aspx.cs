using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace TPI_FINAL_GRUPO8
{
    public partial class FormCategoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int idCategoria;
                if (int.TryParse(Request.QueryString["id"], out idCategoria))
                {
                    CategoriaNegocio negocio = new CategoriaNegocio();
                    Categoria seleccionada = negocio.BuscarPorId(idCategoria);

                    if (seleccionada != null)
                    {
                        tituloCategoria.InnerText = "Editar categoría";
                        txtNombre.Text = seleccionada.Nombre;
                        btnDesactivar.Visible = seleccionada.Activo;
                        btnReactivar.Visible = !seleccionada.Activo;
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            Categoria nueva = new Categoria();
            nueva.Nombre = txtNombre.Text.Trim();

            CategoriaNegocio negocio = new CategoriaNegocio();
            string id = Request.QueryString["id"];

            if (id == null)
            {
                negocio.Agregar(nueva);
            }
            else
            {
                int idCategoria;

                if (!int.TryParse(id, out idCategoria) || idCategoria <= 0)
                {
                    throw new HttpException(400, "El ID de la categoría no es válido.");
                }

                nueva.IdCategoria = idCategoria;
                negocio.Modificar(nueva);
            }

            Response.Redirect("Categorias.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnDesactivar_Click(object sender, EventArgs e)
        {
            pnlConfirmarDesactivacion.Visible = true;
            btnDesactivar.Visible = false;
            accionesGuardar.Visible = false;
        }
        protected void btnCancelarDesactivacion_Click(object sender, EventArgs e)
        {
            pnlConfirmarDesactivacion.Visible = false;
            btnDesactivar.Visible = true;
            accionesGuardar.Visible = true;
        }

        protected void btnConfirmarDesactivacion_Click(object sender, EventArgs e)
        {
            int idCategoria;
            if (!int.TryParse(Request.QueryString["id"], out idCategoria) || idCategoria <= 0)
            {
                throw new HttpException(400, "El ID de la categoría no es válido.");
            }
            CategoriaNegocio negocio = new CategoriaNegocio();
            negocio.Desactivar(idCategoria);
            Response.Redirect("Categorias.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnReactivar_Click(object sender, EventArgs e)
        {
            int idCategoria;
            if (!int.TryParse(Request.QueryString["id"], out idCategoria) || idCategoria <= 0)
            {
                throw new HttpException(400, "El ID de la categoría no es válido.");
            }
            CategoriaNegocio negocio = new CategoriaNegocio();
            negocio.Reactivar(idCategoria);
            Response.Redirect("Categorias.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}