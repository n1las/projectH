/*import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HttpRedirectConfig {

    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> containerCustomizer() {
        return server -> server.addAdditionalTomcatConnectors(redirectConnector());
    }

    private org.apache.catalina.connector.Connector redirectConnector() {
        org.apache.catalina.connector.Connector connector =
                new org.apache.catalina.connector.Connector(
                        org.apache.coyote.http11.Http11NioProtocol.class.getName()
                );
        connector.setScheme("http");
        connector.setPort(8080);        // HTTP-Port intern
        connector.setSecure(false);
        connector.setRedirectPort(8443); // HTTPS-Port intern
        return connector;
    }
}


 */
