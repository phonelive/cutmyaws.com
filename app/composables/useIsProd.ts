export function useIsProd() {
  return typeof window !== 'undefined' && window.location.hostname === 'cutmyaws.com'
}
