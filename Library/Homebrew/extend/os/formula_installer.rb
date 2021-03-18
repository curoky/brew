class FormulaInstaller
  extend T::Sig

  # 不对产物 hash值 进行校验
  sig { void }
  def fetch
    fetch_dependencies

    return if only_deps?

    unless pour_bottle?(output_warning: true)
      formula.fetch_patches
      formula.resources.each(&:fetch)
    end
    # downloader.fetch
    downloader.fetch(verify_download_integrity: false)
  end
end
