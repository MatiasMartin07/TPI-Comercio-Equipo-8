using System;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace Negocio
{
    public class EmailService : IDisposable
    {
        private MailMessage email;
        private SmtpClient server;
        private string remitente;

        public EmailService(string usuarioSmtp, string claveSmtp)
        {
            remitente = "facturas@gestioncomercial.test";

            server = new SmtpClient();
            server.Host = "sandbox.smtp.mailtrap.io";
            server.Port = 2525;
            server.EnableSsl = true;
            server.UseDefaultCredentials = false;
            server.Credentials = new NetworkCredential(
                usuarioSmtp, claveSmtp);
            server.Timeout = 20000;
        }

        public void armarCorreo(
            string emailDestino, string asunto, string cuerpo)
        {
            // Liberar el mensaje anterior si se vuelve a armar.
            if (email != null)
            {
                email.Dispose();
            }

            email = new MailMessage();
            email.From = new MailAddress(
                remitente, "Gestión Comercial");

            email.To.Add(new MailAddress(emailDestino));
            email.Subject = asunto;
            email.Body = cuerpo;
            email.IsBodyHtml = true;
            email.SubjectEncoding = Encoding.UTF8;
            email.BodyEncoding = Encoding.UTF8;
        }

        public void adjuntarPdf(byte[] archivoPdf, string nombreArchivo)
        {
            if (email == null)
            {
                throw new InvalidOperationException(
                    "Primero hay que armar el correo.");
            }

            if (archivoPdf == null || archivoPdf.Length == 0)
            {
                throw new ArgumentException("El PDF está vacío.");
            }

            MemoryStream contenido = new MemoryStream(archivoPdf);

            Attachment adjunto = new Attachment(
                contenido, nombreArchivo, "application/pdf");

            email.Attachments.Add(adjunto);
        }

        public void enviarEmail()
        {
            if (email == null)
            {
                throw new InvalidOperationException(
                    "Primero hay que armar el correo.");
            }

            server.Send(email);
        }

        public void Dispose()
        {
            if (email != null)
            {
                // También libera el adjunto y su contenido en memoria.
                email.Dispose();
            }

            server.Dispose();
        }
    }
}
