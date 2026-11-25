using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace TPI_FINAL_GRUPO8
{
    public partial class DetalleCompra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (usuario.Rol != "Administrador")
            {
                Response.Redirect("Inicio.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string idTexto = Request.QueryString["idCompra"];

                if (string.IsNullOrWhiteSpace(idTexto))
                {
                    Response.Redirect("Compras.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                int idCompra;

                try
                {
                    idCompra = int.Parse(idTexto);
                }
                catch (FormatException)
                {
                    Response.Redirect("Compras.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
                catch (OverflowException)
                {
                    Response.Redirect("Compras.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                if (idCompra <= 0)
                {
                    Response.Redirect("Compras.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                ComprasNegocio negocio = new ComprasNegocio();

                List<Dominio.DetalleCompra> detalles = negocio.ListarDetalles(idCompra);

                gvDetalleCompra.DataSource = detalles;
                gvDetalleCompra.DataBind();
            }
        }
    }
}
