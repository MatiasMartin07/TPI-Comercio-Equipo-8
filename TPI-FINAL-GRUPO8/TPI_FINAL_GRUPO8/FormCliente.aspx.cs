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
    public partial class FormCliente : System.Web.UI.Page
    {
        public bool confirmar { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;
            confirmar = false;

            if (!IsPostBack)
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "")
                {
                    ClienteNegocio neg = new ClienteNegocio();
                    Cliente seleccionado = neg.listarId(id);
                    Session.Add("clienteSeleccionado", seleccionado);

                    txtId.Text = id;
                    txtNombre.Text = seleccionado.Nombre;
                    txtApellido.Text = seleccionado.Apellido;
                    txtDni.Text = seleccionado.Dni;
                    txtEmail.Text = seleccionado.Email;

                    if (!seleccionado.Activo)
                    {
                        btnInactivar.Text = "Reactivar";
                    }
                }
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            //agregar o modificar
            try
            {
                Cliente nuevo = new Cliente();
                ClienteNegocio negocio = new ClienteNegocio();
                string dniIngresado = txtDni.Text.Trim();
                int idClienteActual = string.IsNullOrEmpty(txtId.Text) ? 0 : int.Parse(txtId.Text);

                //valida nombre
                if (string.IsNullOrEmpty(txtNombre.Text))
                {
                    lblErrorNombre.Text = "Debe Ingresar un Nombre";
                    txtNombre.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    txtNombre.BorderColor = System.Drawing.Color.Empty;
                    lblErrorNombre.Text = "";
                }
                nuevo.Nombre = txtNombre.Text;
                if (string.IsNullOrEmpty(txtApellido.Text))
                {
                    lblErrorApellido.Text = "Debe Ingresar un Apellido";
                    txtApellido.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    txtApellido.BorderColor = System.Drawing.Color.Empty;
                    lblErrorApellido.Text = "";
                }
                nuevo.Apellido = txtApellido.Text;
                if (string.IsNullOrEmpty(txtDni.Text))
                {
                    lblDniError.Text = "Debe Ingresar un DNI o CUIT";
                    txtDni.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    txtDni.BorderColor = System.Drawing.Color.Empty;
                    lblDniError.Text = "";

                    if (negocio.ExisteDni(dniIngresado, idClienteActual))
                    {
                        lblDniError.Text = "Ya existe un cliente registrado con este DNI/CUIT.";
                        txtDni.BorderColor = System.Drawing.Color.Red;
                        return;
                    }
                }
                nuevo.Dni = dniIngresado;

                if (string.IsNullOrEmpty(txtEmail.Text))
                {
                    lblEmailError.Text = "Debe Ingresar un Nombre";
                    txtEmail.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    txtEmail.BorderColor = System.Drawing.Color.Empty;
                    lblEmailError.Text = "";
                }
                nuevo.Email = txtEmail.Text;

                nuevo.Activo = true;

                if (Request.QueryString["id"] != null)
                {
                    nuevo.Id = int.Parse(txtId.Text);
                    negocio.modificarCliente(nuevo);
                }
                else
                {
                    negocio.agregarCliente(nuevo);
                }
                Response.Redirect("Clientes.aspx", false);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void btnInactivar_Click(object sender, EventArgs e)
        {
            try
            {
                ClienteNegocio negocio = new ClienteNegocio();
                Cliente seleccionado = (Cliente)Session["clienteSeleccionado"];

                negocio.eliminarLogico(seleccionado.Id, !seleccionado.Activo);
                Response.Redirect("Clientes.aspx", false);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            confirmar = true;
        }

        protected void btnConfirma_Click(object sender, EventArgs e)
        {
            try
            {
                if (cbcConfirma.Checked)
                {
                    ClienteNegocio negocio = new ClienteNegocio();
                    negocio.eliminar(int.Parse(txtId.Text));
                    Response.Redirect("Clientes.aspx", false);
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void txtDni_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtDni.Text))
            {
                lblDniError.Text = string.Empty;
                txtDni.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void txtNombre_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNombre.Text))
            {
                lblErrorNombre.Text = string.Empty;
                txtNombre.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void txtApellido_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtApellido.Text))
            {
                lblErrorApellido.Text = string.Empty;
                txtApellido.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtEmail.Text))
            {
                lblEmailError.Text = string.Empty;
                txtEmail.BorderColor = System.Drawing.Color.Gray;
            }
        }


    }
}