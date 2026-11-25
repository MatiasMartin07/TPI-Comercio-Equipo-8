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
    public partial class Marcas : System.Web.UI.Page
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
                CargarMarcas();
            }
        }

        protected void txtFiltroMarca_TextChanged(object sender, EventArgs e)
        {
            CargarMarcas();
        }

        protected void ddlEstadoMarca_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarMarcas();
        }

        private void CargarMarcas()
        {
            MarcaNegocio negocio = new MarcaNegocio();
            var marcas = negocio.Listar();
            string filtro = txtFiltroMarca.Text.Trim();
            string estado = ddlEstadoMarca.SelectedValue;
            bool hayMarcas = marcas.Count > 0;
            bool filtrarEstado = estado != "todos";

            if (filtro.Length > 0)
            {
                marcas = marcas.FindAll(marca =>
                    marca.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (filtrarEstado)
            {
                bool mostrarActivas = estado == "activos";
                marcas = marcas.FindAll(marca => marca.Activo == mostrarActivas);
            }

            gvMarcas.EmptyDataText = hayMarcas && (filtro.Length > 0 || filtrarEstado)
                ? "No se encontraron marcas con los filtros seleccionados."
                : "No hay marcas para mostrar.";

            gvMarcas.DataSource = marcas;
            gvMarcas.DataBind();
        }
    }
}