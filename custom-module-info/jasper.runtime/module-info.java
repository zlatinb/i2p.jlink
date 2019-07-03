module jasper.runtime {
    requires ecj.hacked;
    requires java.logging;
    requires java.management;
    requires jetty.util;
    requires org.mortbay.jetty;

    requires transitive ant.hacked;
    requires transitive commons.el;
    requires transitive java.desktop;
    requires transitive java.instrument;
    requires transitive java.naming;
    requires transitive java.xml;
    requires transitive javax.servlet;

    exports org.apache.jasper;
    exports org.apache.jasper.compiler;
    exports org.apache.jasper.compiler.tagplugin;
    exports org.apache.jasper.el;
    exports org.apache.jasper.runtime;
    exports org.apache.jasper.security;
    exports org.apache.jasper.servlet;
    exports org.apache.jasper.tagplugins.jstl;
    exports org.apache.jasper.tagplugins.jstl.core;
    exports org.apache.jasper.util;
    exports org.apache.jasper.xmlparser;
    exports org.apache.juli.logging;
    exports org.apache.tomcat;
    exports org.apache.tomcat.util;
    exports org.apache.tomcat.util.buf;
    exports org.apache.tomcat.util.collections;
    exports org.apache.tomcat.util.compat;
    exports org.apache.tomcat.util.descriptor;
    exports org.apache.tomcat.util.descriptor.tagplugin;
    exports org.apache.tomcat.util.descriptor.tld;
    exports org.apache.tomcat.util.descriptor.web;
    exports org.apache.tomcat.util.digester;
    exports org.apache.tomcat.util.file;
    exports org.apache.tomcat.util.res;
    exports org.apache.tomcat.util.scan;
    exports org.apache.tomcat.util.security;
    exports org.eclipse.jetty.apache.jsp;
    exports org.eclipse.jetty.jsp;

    provides javax.servlet.ServletContainerInitializer with
        org.eclipse.jetty.apache.jsp.JettyJasperInitializer;
    provides org.apache.juli.logging.Log with
        org.eclipse.jetty.apache.jsp.JuliLog;
    uses org.apache.juli.logging.Log;

}
