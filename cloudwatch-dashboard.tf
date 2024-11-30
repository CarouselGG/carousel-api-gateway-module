# CloudWatch Dashboard with Line Chart Widgets
resource "aws_cloudwatch_dashboard" "api_gateway_dashboard" {
  count = var.enable_dashboards ? 1 : 0

  dashboard_name = "${var.api_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        "type" : "metric",
        "x" : 0,
        "y" : 0,
        "width" : 24,
        "height" : 6,
        "properties" : {
          "metrics" : [
            ["API-Gateway-Metrics", "TotalRequests"],
            [".", aws_cloudwatch_log_metric_filter.errors_3xx.name],
            [".", aws_cloudwatch_log_metric_filter.errors_4xx.name],
            [".", aws_cloudwatch_log_metric_filter.errors_5xx.name],
            [".", aws_cloudwatch_log_metric_filter.errors_5x.name],
          ],
          "view" : "timeSeries",
          "stacked" : false,
          "region" : "${var.aws_region}",
          "stat" : "Sum",
          "period" : 300,
          "title" : "API Gateway Requests and Errors"
        }
      }
    ]
  })
}
