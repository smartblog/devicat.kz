class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy if current_user.author?(@attachment.attachable)
  end
end
