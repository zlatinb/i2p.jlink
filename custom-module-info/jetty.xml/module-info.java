module jetty.xml {
    requires jetty.util;

    requires transitive java.xml;

    exports org.eclipse.jetty.xml;
    uses org.eclipse.jetty.xml.ConfigurationProcessorFactory;
}
