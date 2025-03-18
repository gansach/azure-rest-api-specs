import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Evaluation Result resource Definition")
@discriminator("EvaluationResultType")
model EvaluationResult {
  @doc("Type of Evaluation result")
  EvaluationResultType: EvaluationResultType;

    // Todo find PR that has the rest of the meta-data
  ...AssetBase;
}

@doc("Paged collection of Evaluation Result items.")
@pagedResult
model PagedEvaluationResult {
  @doc("The list of Evaluation Results.")
  @extension("x-ms-identifiers", [])
  @items
  value: EvaluationResult[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<EvaluationResult>;
}

union EvaluationResultType {
  string,

  @doc("Cloud Evaluation Result")
  CloudEvaluationResult: "CloudEvaluationResult",

  @doc("Red Team Result")
  RedTeamResult: "RedTeamResult",

  @doc("Benchmark result: legacy")
  BenchmarkResult: "BenchmarkResult",
}
