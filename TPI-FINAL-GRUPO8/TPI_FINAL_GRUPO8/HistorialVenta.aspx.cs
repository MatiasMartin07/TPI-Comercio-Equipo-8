using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI_FINAL_GRUPO8;

namespace TPI_FINAL_GRUPO8
{
    public partial class HistorialVenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                VentaNegocio negocio = new VentaNegocio();
                gvVentas.DataSource = negocio.listar();
                gvVentas.DataBind();
            }
        }

        protected void gvVentas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (string.IsNullOrEmpty(e.CommandArgument?.ToString()))
                return;
            int idVenta = Convert.ToInt32(e.CommandArgument); ;

            if (e.CommandName == "VerFactura")
            {
                Response.Redirect("Facturas.aspx?id=" + idVenta);
            }
            else if(e.CommandName == "AnularVenta")
            {
                try
                {
                    VentaNegocio negocio = new VentaNegocio();
                    bool anulado = negocio.anularVenta(idVenta);

                    if (anulado)
                    {
                        gvVentas.DataSource = negocio.listar();
                        gvVentas.DataBind();
                    }
                    else
                    {
                        lblError.Text = "No se puede anular la venta";
                    }
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex.ToString());
                }
            }
        }

        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            cargarVenta();
        }

        protected void ddlEstadoVenta_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarVenta();
        }
        private void cargarVenta()
        {
            VentaNegocio negocio = new VentaNegocio();
            var venta = negocio.listar();

            string filtro = txtFiltro.Text.Trim();
            string estado = ddlEstadoVenta.SelectedValue;
            bool filtrarEstado = estado != "Todos";


            if (filtro.Length > 0)
            {
                venta = venta.FindAll(ventas => ventas.Cliente.Nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0 ||
                ventas.NroFactura.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0 || ventas.Fecha.ToString().IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0);
            }
            if (filtrarEstado)
            {
                bool mostrarActivos = estado == "Anulados";
                venta = venta.FindAll(ventas => ventas.Anulado == mostrarActivos);

            }

            gvVentas.DataSource = venta;
            gvVentas.DataBind();

        }

        protected void gvVentas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool anulado = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "Anulado"));
                Usuario usuario = Session["usuarioLogueado"] as Usuario;
                bool esAdmin = usuario != null && usuario.Rol == "Administrador";

                Control btnAnular = e.Row.FindControl("btnAnular");
                if (btnAnular != null)
                {
                    btnAnular.Visible = !anulado && esAdmin;
                }
            }
        }
    }
}