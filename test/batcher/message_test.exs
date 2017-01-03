defmodule Aelita2.BatcherMessageTest do
  use ExUnit.Case, async: true

  test "generate configuration problem message" do
  	expected_message = "# Configuration problem\nExample problem"
  	actual_message = Aelita2.Batcher.Message.generate_message({:config, "Example problem"})
    assert expected_message == actual_message
  end

  test "generate retry message" do
  	expected_message = "# Build failed (retrying...)\n  * stat"
  	example_statuses = [%Aelita2.Status{identifier: "stat"}]
  	actual_message = Aelita2.Batcher.Message.generate_message({:retrying, example_statuses})
    assert expected_message == actual_message
  end

  test "generate retry message w/ url" do
  	expected_message = "# Build failed (retrying...)\n  * [stat](x)"
  	example_statuses = [%Aelita2.Status{identifier: "stat", url: "x"}]
  	actual_message = Aelita2.Batcher.Message.generate_message({:retrying, example_statuses})
    assert expected_message == actual_message
  end

  test "generate failure message" do
  	expected_message = "# Build failed\n  * stat"
  	example_statuses = [%Aelita2.Status{identifier: "stat"}]
  	actual_message = Aelita2.Batcher.Message.generate_message({:failed, example_statuses})
    assert expected_message == actual_message
  end

  test "generate success message" do
  	expected_message = "# Build succeeded\n  * stat"
  	example_statuses = [%Aelita2.Status{identifier: "stat"}]
  	actual_message = Aelita2.Batcher.Message.generate_message({:succeeded, example_statuses})
    assert expected_message == actual_message
  end

  test "generate conflict message" do
  	expected_message = "# Merge conflict"
  	actual_message = Aelita2.Batcher.Message.generate_message({:conflict, :failed})
    assert expected_message == actual_message
  end

  test "generate conflict/retry message" do
  	expected_message = "# Merge conflict (retrying...)"
  	actual_message = Aelita2.Batcher.Message.generate_message({:conflict, :retrying})
    assert expected_message == actual_message
  end
end
