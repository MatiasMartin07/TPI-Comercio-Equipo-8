using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }
            if (usuario.Rol != "Administrador")
            {
                Response.Redirect("Inicio.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                CargarCategorias();
            }
        }

        protected void txtFiltroCategoria_TextChanged(object sender, EventArgs e) {
            CargarCategorias();
        }

        protected void ddlEstadoCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarCategorias();
        }

        private void CargarCategorias()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            var categorias = negocio.Listar(incluirInactivas: true);
            string filtro = txtFiltroCategoria.Text.Trim();
            string estado = ddlEstadoCategoria.SelectedValue;
            bool hayCategorias = categorias.Count > 0;
            bool filtrarEstado = estado != "todos";

            if (filtro.Length > 0)
            {
                categorias = categorias.FindAll(categoria =>
                    categoria.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (filtrarEstado)
            {
                bool mostrarActivas = estado == "activos";
                categorias = categorias.FindAll(categoria => categoria.Activo == mostrarActivas);
            }

            gvCategorias.EmptyDataText = hayCategorias && (filtro.Length > 0 || filtrarEstado)
                ? "No se encontraron categorías con los filtros seleccionados."
                : "No hay categorías para mostrar.";

            gvCategorias.DataSource = categorias;
            gvCategorias.DataBind();
        }
    }
}