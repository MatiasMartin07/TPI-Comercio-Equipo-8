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
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }
            bool esAdmin = usuario.Rol == "Administrador";

            aNuevoProducto.Visible = esAdmin;
            gvProductos.Columns[gvProductos.Columns.Count - 1].Visible = esAdmin;

            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        protected void txtFiltroProducto_TextChanged(object sender, EventArgs e)
        {
            CargarProductos();
        }

        protected void ddlEstadoProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarProductos();
        }

        private void CargarProductos()
        {
            ProductoNegocio negocio = new ProductoNegocio();
            var productos = negocio.Listar();
            string filtro = txtFiltroProducto.Text.Trim();
            string estado = ddlEstadoProducto.SelectedValue;
            bool hayProductos = productos.Count > 0;
            bool filtrarEstado = estado != "todos";

            if (filtro.Length > 0)
            {
                productos = productos.FindAll(producto =>
                    producto.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    producto.Marca.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    producto.Categoria.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (filtrarEstado)
            {
                bool mostrarActivos = estado == "activos";
                productos = productos.FindAll(producto => producto.Activo == mostrarActivos);
            }

            gvProductos.EmptyDataText = hayProductos && (filtro.Length > 0 || filtrarEstado)
                ? "No se encontraron productos con los filtros seleccionados."
                : "No hay productos para mostrar.";

            gvProductos.DataSource = productos;
            gvProductos.DataBind();
        }

        protected void gvProductos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Usuario usuario = Session["usuarioLogueado"] as Usuario;
                HyperLink idEditar = e.Row.FindControl("idEditar") as HyperLink;

                if (idEditar != null)
                {
                    idEditar.Visible = usuario != null && usuario.Rol == "Administrador";
                }
            }
        }
    }
}