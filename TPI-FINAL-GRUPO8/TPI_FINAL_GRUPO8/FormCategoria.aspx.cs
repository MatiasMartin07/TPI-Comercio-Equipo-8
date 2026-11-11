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
    }
}