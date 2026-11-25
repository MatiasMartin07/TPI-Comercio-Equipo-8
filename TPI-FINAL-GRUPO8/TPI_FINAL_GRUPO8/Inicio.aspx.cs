using Dominio;
using Negocio;
using System;
using System.Globalization;
using System.Linq;

namespace TPI_FINAL_GRUPO8
{
    public partial class Inicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if(usuario == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }
            bool esAdmin = string.Equals(usuario.Rol, "Administrador", StringComparison.OrdinalIgnoreCase);

            divMarcas.Visible = esAdmin;
            divCategorias.Visible = esAdmin;
            divProveedores.Visible = esAdmin;
            divCompras.Visible = esAdmin;
            divUsuarios.Visible = esAdmin;

            if (!IsPostBack)
            {
                CargarStock();
                CargarVentasDelDia();
            }
        }

        private void CargarStock()
        {
            try
            {
                ProductoNegocio negocio = new ProductoNegocio();

                // Toma los tres productos activos con menor stock.
                var productos = negocio.Listar()
                    .Where(p => p.Activo)
                    .OrderBy(p => p.StockActual)
                    .ThenBy(p => p.Nombre)
                    .Take(3)
                    .ToList();

                lblSinProductos.Visible = productos.Count == 0;

                // Usa la misma escala para todas las barras.
                decimal escala = 1;

                if (productos.Count > 0)
                {
                    escala = Math.Max(1,
                        productos.Max(p =>
                            Math.Max(p.StockActual, p.StockMinimo)));
                }

                rptStock.DataSource = productos.Select(p => new
                {
                    p.Nombre,
                    p.StockActual,
                    p.StockMinimo,

                    AnchoActual = (Math.Max(0, p.StockActual)
                        * 100m / escala)
                        .ToString("0.##", CultureInfo.InvariantCulture),

                    AnchoMinimo = (Math.Max(0, p.StockMinimo)
                        * 100m / escala)
                        .ToString("0.##", CultureInfo.InvariantCulture)
                }).ToList();

                rptStock.DataBind();
            }
            catch (Exception ex)
            {
                Trace.Warn("Inicio", "Error al cargar el stock.", ex);

                lblSinProductos.Text =
                    "No se pudo cargar el resumen de stock.";
                lblSinProductos.Visible = true;
            }
        }

        private void CargarVentasDelDia()
        {
            try
            {
                VentaNegocio negocio = new VentaNegocio();
                DateTime hoy = DateTime.Today;

                // Cuenta solo las ventas de hoy que no estén anuladas.
                var ventas = negocio.listar()
                    .Where(v => v.Fecha.Date == hoy && !v.Anulado)
                    .ToList();

                decimal total = ventas.Sum(v => v.Total);

                lblTotalVentasDia.Text = total.ToString(
                    "C2", CultureInfo.GetCultureInfo("es-AR"));

                lblCantidadVentasDia.Text = ventas.Count.ToString();
            }
            catch (Exception ex)
            {
                Trace.Warn("Inicio",
                    "Error al cargar las ventas del día.", ex);

                lblTotalVentasDia.Text = "No disponible";
                lblCantidadVentasDia.Text = "—";
            }
        }
    }
}