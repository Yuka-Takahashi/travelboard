package ph.jpn.travelboard;
import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ImageConv extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException{
		response.setContentType("image/jpeg");
		int intMaxWidth=200;
		String strWidth = request.getParameter("width");
		if(strWidth!=null){
			intMaxWidth = Integer.parseInt(strWidth);
		}
		int intMaxHeight=200;
		String strHeight = request.getParameter("height");
		if(strHeight!=null){
			intMaxHeight = Integer.parseInt(strHeight);
		}
		String strUri=request.getRequestURI();
		int intLength = strUri.length();
		int p = strUri.lastIndexOf('/',intLength);
		String strImageFile = BlogSettings.AppDir+"/images/"+strUri.substring(p+1);

		BufferedImage bi = javax.imageio.ImageIO.read(new File(strImageFile));
		int intHeight=bi.getHeight();
		int intWidth=bi.getWidth();

		float fScale=1;
		float fScaleWidth=1;
		float fScaleHeight=1;

		if(intWidth > intMaxWidth){
			fScaleWidth = (float)intMaxWidth/intWidth;
		}

		if(intHeight > intMaxHeight){
			fScaleHeight = (float)intMaxHeight/intHeight;
		}

		if(fScaleWidth > fScaleHeight){
			fScale = fScaleHeight;
		}else{
			fScale = fScaleWidth;
		}

		Float fWidth = new Float(intWidth*fScale);
		int intScaledWidth = fWidth.intValue();

		Float fHeight = new Float(intHeight*fScale);
		int intScaledHeight = fHeight.intValue();

		BufferedImage bi2 = new BufferedImage(intScaledWidth,
			intScaledHeight,BufferedImage.TYPE_INT_BGR);
		Graphics2D g2 = bi2.createGraphics();
		g2.drawImage(bi,0,0,intScaledWidth,intScaledHeight,null);

		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		com.sun.image.codec.jpeg.JPEGCodec.createJPEGEncoder(baos).encode(bi2);
		response.setContentLength(baos.size());
		ServletOutputStream output =  response.getOutputStream();
		baos.writeTo(output);
		output.flush();
		g2.dispose();
	}
}
