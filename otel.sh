# Language guides: https://grafana.com/docs/grafana-cloud/monitor-applications/application-observability/setup/quickstart/
export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"
export OTEL_EXPORTER_OTLP_ENDPOINT="https://otlp-gateway-prod-eu-west-2.grafana.net/otlp"
# Python requires "Basic%20" instead of "Basic "
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Basic MTE5NzQz......"

# Confirm JSON auth header is as expected
echo "{\"Authorization\":\"$(echo $OTEL_EXPORTER_OTLP_HEADERS | sed 's/Authorization=//')\"}"

# Run command to add
heroku telemetry:add "$OTEL_EXPORTER_OTLP_ENDPOINT" \
  --app fir-demo-app \
  --signals traces,logs,metrics \
  --transport http \
  --headers "{\"Authorization\":\"$(echo $OTEL_EXPORTER_OTLP_HEADERS | sed 's/Authorization=//')\"}"

